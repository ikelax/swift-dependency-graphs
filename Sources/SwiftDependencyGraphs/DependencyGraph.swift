import OrderedCollections

public struct DependencyGraph<V> where V: Hashable, V: Identifiable {
  typealias Edge = (V, V)

  /// The vertices of the dependency graph.
  public internal(set) var vertices: Set<V> = []

  // For efficiency, two hashsets are maintained.

  /// The dictionary maps the edge `v --> w` as `[w: v]`. `w` is the key and `v` the value.
  public internal(set) var incomingEdges: [V.ID: OrderedSet<V>] = [:]

  /// The dictionary maps the edge `v --> w` as `[v: w]`. `v` is the key and `w` the value.
  public internal(set) var outgoingEdges: [V.ID: OrderedSet<V>] = [:]

  func contains(vertex: V) -> Bool {
    return contains(vertexWith: { vertexInGraph in vertexInGraph.id == vertex.id })
  }

  /// Returns `true` iff at least one vertex satisfies the `predicate`.
  func contains(vertexWith predicate: (V) -> Bool) -> Bool {
    return vertices.contains(where: { vertex in predicate(vertex) })
  }

  /// Traverses the vertices in the dependency graph that are reachable from `vertex` and searches for the first
  /// vertex that satisfies `predicate`.
  /// - Parameters:
  ///   - vertex: The vertex the depth-first search starts from
  ///   - direction: The direction of the depth-first search. It is either `.forwards` and
  ///   therefore in the direction of the arrows of the edges or `.backwards`.
  ///   - predicate: The predicate to satisfy
  ///   - Returns: The first vertex found satisfying `predicate` if such a vertex exists. Otherwise, it returns `nil`.
  ///   If `vertex` does not exist in the graph or does not have neighbours, it just returns `nil`.
  public func depthFirstSearch(
    startingFrom vertex: V,
    in direction: TraverseDirection,
    firstWhere predicate: (V) -> Bool
  ) -> V? {
    depthFirstSearchImpl(
      startingFrom: vertex,
      in: direction,
      withVisited: [],
      firstWhere: predicate
    )
  }

  /// Traverses the vertices in the dependency graph and reduces the visited vertices.
  /// - Parameters:
  ///   - vertex: The vertex the depth-first search starts from
  ///   - direction: The direction of the depth-first search. It is either `.forwards`
  ///   and therefore in the direction of the arrows of the edges or `.backwards`.
  ///   - reducer: Reduces the visited vertices.
  ///   - accumulator: The accumulator for the reducer.
  /// - Returns: The accumulated value. If `vertex` does not exist in the graph or does not have neighbours,
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

  /// Traverses the vertices in the dependency graph that are reachable from `vertex` and searches for the first
  /// vertex that satisfies `predicate`.
  /// - Parameters:
  ///   - vertex: The vertex the depth-first search starts from
  ///   - direction: The direction of the depth-first search. It is either `.forwards` and
  ///   therefore in the direction of the arrows of the edges or `.backwards`.
  ///   - visited: Tracks vertices that were already visited by the depth-first search
  ///   - predicate: The predicate to satisfy
  ///   - Returns: The first vertex found satisfying `predicate` if such a vertex exists. Otherwise, it returns `nil`.
  ///   If `vertex` does not exist in the graph or does not have neighbours, it just returns `nil`.
  internal func depthFirstSearchImpl(
    startingFrom vertex: V,
    in direction: TraverseDirection,
    withVisited visited: Set<V>,
    firstWhere predicate: (V) -> Bool
  ) -> V? {
    guard let neighbours = self.neighbours(of: vertex, in: direction)
    else {
      return nil
    }

    if visited.contains(vertex) {
      return nil
    }

    if predicate(vertex) {
      return vertex
    }

    var visited = visited
    visited.insert(vertex)

    for neighbour in neighbours {
      if let vertex = depthFirstSearchImpl(
        startingFrom: neighbour,
        in: direction,
        withVisited: visited,
        firstWhere: predicate
      ) {
        return vertex
      }
    }

    return nil
  }

  /// Traverses the vertices in the dependency graph that are reachable from `vertex` and reduces the visited vertices.
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
    guard let neighbours = self.neighbours(of: vertex, in: direction)
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

  /// Removes the edge from the graph.
  /// - Parameter edge: The edge to remove.
  /// - Returns: The edge if it was in the graph and `nil` otherwise.
  @discardableResult mutating public func remove(edge: (V, V)) -> (V, V)? {
    let head = edge.0
    let tail = edge.1

    guard vertices.contains(where: {vertex in vertex.id == head.id}),
          vertices.contains(where: {vertex in vertex.id == tail.id}),
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

  /// Checks if the dependency graph with `edge` is cyclic.
  /// - Parameter edge: The edge to add to the dependency graph
  /// - Returns: True iff the dependency graph with `edge` is cyclic.
  internal func isCyclicWith(edge: (V, V)) -> Bool {
    var temporaryDependencyGraph = self
    let headVertex = edge.0
    let tailVertex = edge.1
    temporaryDependencyGraph.vertices.insert(headVertex)
    temporaryDependencyGraph.vertices.insert(tailVertex)
    _ = temporaryDependencyGraph.incomingEdges[edge.1.id]?.unordered.insert(edge.0)
    _ = temporaryDependencyGraph.outgoingEdges[edge.0.id]?.unordered.insert(edge.1)

    // A dependency graph G is acyclic. If G with the edge e is cyclic,
    // the cycle in G must contain e. Otherwise, G would be cyclic.
    // Hence, it suffices to check if it is possible to reach headVertex
    // from tailVertex. If there such a path P, we have found a cycle by
    // combining P with e.
    return temporaryDependencyGraph.depthFirstSearchImpl(
      startingFrom: tailVertex, in: .forwards, withVisited: [],
      firstWhere: { vertex in
        vertex.id == headVertex.id
      }) != nil
  }
}
