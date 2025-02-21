import OrderedCollections

public struct DependencyGraph<V>: Sequence where V: Hashable, V: Identifiable {
  typealias Edge = (V, V)

  /// The vertices of the dependency graph.
  public internal(set) var vertices: [V] = []

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

  /// This is required for the Sequence Protocol conformance.
  /// - Returns: The iterator
  public func makeIterator() -> DepthFirstSearchIterator<V> {
    return DepthFirstSearchIterator<V>(self)
  }
}
