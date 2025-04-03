import OrderedCollections

public struct DependencyGraph<V> where V: Hashable, V: Identifiable, V: Sendable {
  typealias Edge = (V, V)

  /// The vertices of the dependency graph.
  public internal(set) var vertices: [V.ID: V] = [:]

  // For efficiency, two hashsets are maintained.

  /// The dictionary maps the edge `v --> w` as `[w: v]`. `w` is the key and `v` the value.
  public internal(set) var incomingEdges: [V.ID: OrderedSet<V>] = [:]

  /// The dictionary maps the edge `v --> w` as `[v: w]`. `v` is the key and `w` the value.
  public internal(set) var outgoingEdges: [V.ID: OrderedSet<V>] = [:]

  func contains(vertex: V) -> Bool {
    contains(vertexWith: { vertexInGraph in vertexInGraph.id == vertex.id })
  }

  /// Returns `true` iff at least one vertex satisfies the `predicate`.
  func contains(vertexWith predicate: (V) -> Bool) -> Bool {
    vertices.contains(where: { _, vertex in predicate(vertex) })
  }

  public func contains(edge: (V, V)) -> Bool {
    true
  }

  public func contains(edgeWith predicate: (V, V) -> Bool) -> Bool {
    true
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

  /// A neighbour of a vertex in a graph is a vertex that is connected to it by an edge.
  /// - Parameters:
  ///   - vertex: The vertex
  ///   - direction: The direction of the edge
  /// - Returns: The neighbours of the vertex
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

  public typealias RemoveVertexResult = Result<RemoveVertexSuccess<V>, RemoveVertexError<V>>

  /// Removes a vertex from the graph.
  /// - Parameters:
  ///   - vertex: The removed vertex.
  ///   - isForced: `true` to also remove edges to other vertices if there are any.
  ///   `false` to remove `vertex` iff it has no edges to other vertices.
  /// - Returns: The result of the removal. If successful, the removed vertex and edges are returned.
  /// Otherwise, the reason for the failure is returned.
  @discardableResult mutating public func remove(vertex: V, byForce isForced: Bool = false) -> RemoveVertexResult {
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
}
