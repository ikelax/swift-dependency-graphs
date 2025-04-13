import OrderedCollections

public struct DependencyGraph<V> where V: Hashable, V: Identifiable, V: Sendable {
  typealias Edge = (V, V)

  /// The vertices of the dependency graph.
  public internal(set) var vertices: [V.ID: V] = [:]

  // For efficiency, two hashsets are maintained.

  /// The dictionary maps edges of the form `head --> tail` as `[tail.id: Heads]`
  /// where `Heads` is the set of heads for this specific tail.
  public internal(set) var incomingEdges: [V.ID: OrderedSet<V>] = [:]

  /// The dictionary maps edges of the form `head --> tail` as `[head.id: Tails]`
  /// where `Tails` is the set of tails for this specific head.
  public internal(set) var outgoingEdges: [V.ID: OrderedSet<V>] = [:]

  /// Returns a Boolean value indicating whether the graph contains the given vertex.
  /// - Parameter vertex: The vertex to contain.
  /// - Returns: `true` if the graph contains the given vertex; otherwise `false`.
  public func contains(vertex: V) -> Bool {
    // vertices maps a the ID of a vertex to the vertex.
    // So, a valid vertex ID will never map to nil.
    vertices[vertex.id] != nil
  }

  /// Returns a Boolean value indicating whether the graph contains a vertex
  /// that satisfies the given predicate.
  /// - Parameter predicate: A closure that takes a vertex of the graph as its argument
  /// and returns a Boolean value that indicates whether the passed vertex represents a match.
  /// - Returns: `true` if the graph contains a vertex that satisfies `predicate`; otherwise `false`.
  public func containsVertex(with predicate: (V) -> Bool) -> Bool {
    vertices.contains(where: { _, vertex in predicate(vertex) })
  }

  /// Returns a Boolean value indicating whether the graph contains the given edge.
  /// - Parameter edge: The edge to contain.
  /// - Returns: `true` if the graph contains the given edge; otherwise `false`.
  public func contains(edge: (head: V, tail: V)) -> Bool {
    guard let edges = outgoingEdges[edge.head.id] else {
      return false
    }

    return edges.contains(where: { tail in tail.id == edge.tail.id })
  }

  /// Returns a Boolean value indicating whether the graph contains an edge
  /// that satisfies the given predicate.
  /// - Parameter predicate: A closure that takes an edge represented as a tuple of vertices
  /// of the graph as its argument and returns a Boolean value that indicates
  /// whether the passed edge represents a match.
  /// - Returns: `true` if the graph contains an edge that satisfies `predicate`; otherwise `false`.
  public func containsEdge(with predicate: (V, V) -> Bool) -> Bool {
    return outgoingEdges.contains(where: { edge in
      guard let head = vertices[edge.key] else {
        return false
      }

      return edge.value.contains(where: { tail in predicate(head, tail) })
    })
  }

  /// Traverses the vertices in the dependency graph and reduces the visited vertices.
  /// - Parameters:
  ///   - vertex: The vertex the depth-first search starts from
  ///   - direction: The direction of the depth-first search. It is either `.forwards`
  ///   and therefore in the direction of the arrows of the edges or `.backwards`.
  ///   - reducer: Reduces the visited vertices.
  ///   - accumulator: The accumulator for the reducer.
  /// - Returns: The accumulated value. If the vertex does not exist in the graph or does not have neighbours,
  /// it just returns the `accumulator`.
  public func depthFirstSearch<T>(
    startingFrom vertex: V,
    in direction: TraverseDirection,
    reduceWith reducer: (_ accumulator: T, _ currentVertex: V) -> T,
    withInitialValue accumulator: T
  ) -> T {
    depthFirstSearchImpl(
      startingFrom: vertex,
      in: direction,
      withVisited: [],
      reduceWith: reducer,
      withInitialValue: accumulator
    )
  }

  /// Traverses the vertices in the dependency graph and reduces the visited vertices.
  /// - Parameters:
  ///   - vertex: The vertex the depth-first search starts from
  ///   - direction: The direction of the depth-first search. It is either `.forwards` and
  ///   therefore in the direction of the arrows of the edges or `.backwards`.
  ///   - visited: Tracks vertices that were already visited by the depth-first search.
  ///   - reducer: Reduces the visited vertices.
  ///   - accumulator: The accumulator for the reducer.
  /// - Returns: The accumulated value. If the vertex does not exist in the graph or does not have neighbours,
  /// it just returns the `accumulator`.
  internal func depthFirstSearchImpl<T>(
    startingFrom vertex: V,
    in direction: TraverseDirection,
    withVisited visited: Set<V>,
    reduceWith reducer: (_ accumulator: T, _ currentVertex: V) -> T,
    withInitialValue accumulator: T
  ) -> T {
    guard let neighbours = self.neighbours(of: vertex, in: .forwards)
    else {
      assert(
        vertices[vertex.id] == nil,
        """
        neighbours returns nil if the vertex is not in the graph.
        Thus, it is implicitly also checked if the vertex is in the graph.
        """
      )
      return accumulator
    }

    if visited.contains(vertex) {
      return accumulator
    }

    return neighbours.reduce(reducer(accumulator, vertex)) { currentAccumulator, neighbour in
      var visited = visited
      visited.insert(vertex)

      return depthFirstSearchImpl(
        startingFrom: neighbour,
        in: direction,
        withVisited: visited,
        reduceWith: reducer,
        withInitialValue: currentAccumulator
      )
    }
  }

  /// A neighbour of a vertex is connected to it by an edge. For `.forwards` direction, it returns
  /// only the outgoing edges. For `.backwards` direction, it returns only the incoming edges.
  /// - Parameters:
  ///   - vertex: The vertex of which all neighbours are returned.
  ///   - direction: The direction of edges to consider, ignoring edges of other directions.
  /// - Returns: All neighbours of `vertex` with an edge in `direction`, or `nil` if the vertex is not in the graph.
  public func neighbours(
    of vertex: V,
    in direction: TraverseDirection
  ) -> OrderedSet<V>? {
    let edges =
      if direction == .forwards {
        outgoingEdges
      } else {
        incomingEdges
      }
    return edges[vertex.id]
  }

  /// A neighbour of a vertex is connected to it by an edge. It computes the neighbours
  /// for incoming and outgoing edges.
  /// - Parameters:
  ///   - vertex: The vertex of which all neighbours are returned.
  /// - Returns: The neighbours of the vertex if the vertex is in the graph and `nil` otherwise.
  public func neighbours(of vertex: V) -> OrderedSet<V>? {
    let backwards = neighbours(of: vertex, in: .backwards)

    guard let forwards = neighbours(of: vertex, in: .forwards) else {
      return backwards
    }

    guard let backwards else {
      return forwards
    }

    return forwards.union(backwards)
  }

  public typealias RemoveVertexResult = Result<RemoveVertexSuccess<V>, RemoveVertexError<V>>

  /// Removes a vertex from the graph.
  /// - Parameters:
  ///   - vertex: The removed vertex.
  ///   - isForced: `true` to also remove edges to other vertices if there are any.
  ///   `false` to remove `vertex` iff it has no edges to other vertices.
  /// - Returns: The result of the removal. If successful, the removed vertex and edges are returned.
  /// Otherwise, the reason for the failure is returned.
  @discardableResult mutating public func remove(
    vertex: V, byForce isForced: Bool = false
  ) -> RemoveVertexResult {
    guard vertices[vertex.id] != nil else {
      return .failure(RemoveVertexError.notInGraph(vertex))
    }

    if !isForced {
      guard let outgoingEdges = outgoingEdges[vertex.id],
        outgoingEdges.isEmpty,
        let incomingEdges = incomingEdges[vertex.id],
        incomingEdges.isEmpty
      else {
        return .failure(
          RemoveVertexError.hasEdgesTo(
            incoming: incomingEdges[vertex.id] ?? [],
            outgoing: outgoingEdges[vertex.id] ?? []
          )
        )
      }
    }

    vertices.removeValue(forKey: vertex.id)

    // The default values in the coalesces are only for the type system.
    // In a bug-free library, the values should always exist
    // because the vertex is in the graph and therefore not nil.
    if isForced {
      return .success(
        RemoveVertexSuccess<V>(
          vertex: vertex,
          outgoingEdges: outgoingEdges.removeValue(forKey: vertex.id) ?? [],
          incomingEdges: incomingEdges.removeValue(forKey: vertex.id) ?? []
        )
      )
    }

    return .success(RemoveVertexSuccess(vertex: vertex, outgoingEdges: [], incomingEdges: []))
  }

  /// Removes the edge from the graph.
  /// - Parameter edge: The edge to remove.
  /// - Returns: The edge if it was in the graph and `nil` otherwise.
  @discardableResult mutating public func remove(edge: (V, V)) -> (V, V)? {
    let head = edge.0
    let tail = edge.1

    guard vertices[head.id] != nil,
      vertices[tail.id] != nil,
      // The type ensures that this is true if and only if
      // incomingEdges[tail.id]?.contains(head) is also true.
      let isEdgeInGraph = outgoingEdges[head.id]?.contains(tail),
      isEdgeInGraph
    else {
      return nil
    }

    incomingEdges[tail.id]?.remove(head)
    outgoingEdges[head.id]?.remove(tail)

    return edge
  }

  /// Inserts the given vertex into the graph if it is not already present.
  /// Does not update existing vertices in the graph, identified by `V.id`,
  /// even if `newVertex`'s other properties are different.
  ///
  /// - Parameter newVertex: A vertex to insert into the graph.
  /// - Returns: `(true, newVertex)` if `newVertex` was not contained in the graph.
  /// If a vertex identical to `newVertex` was already contained in the graph, the method returns `(false, oldVertex)`,
  /// where `oldVertex` is the vertex that was identical to `newVertex`.
  @discardableResult mutating public func insert(newVertex: V) -> (
    inserted: Bool, vertexAfterInsert: V
  ) {
    if let oldVertex = vertices[newVertex.id] {
      return (false, oldVertex)
    }

    vertices[newVertex.id] = newVertex
    return (true, newVertex)
  }
}
