public struct DepthFirstSearchIterator<V>: IteratorProtocol where V: Hashable, V: Identifiable {
  let graph: DependencyGraph<V>
  var visited: Set<V> = []
  var currentVertex: V?
  let traverseDirection = TraverseDirection.forwards

  init(_ graph: DependencyGraph<V>) {
    self.graph = graph
    currentVertex = graph.vertices.first
  }

  /// Traverses over the graph with depth-first search in direction of the edges.
  /// - Returns: The next vertex in the graph or nil if there is none
  public mutating func next() -> V? {
    // If the graph is empty, there are no vertices to iterate.
    // So, we return nil.
    guard let currentVertex else {
      return nil
    }

    // Find the vertex depth-first search would visit next from `vertex`.
    // If there is no next vertex, we look for next unvisited vertex.
    // If all vertices were already visited, we are done with iterating.
    let nextVertex =
      nextVertexInDepthFirstSearch(startingFrom: currentVertex, withVisited: visited)
      ?? graph.vertices.first(where: { !visited.contains($0) })

    if let nextVertex {
      self.visited.insert(nextVertex)
    }

    self.currentVertex = nextVertex
    return nextVertex
  }

  /// Returns the next vertex depth-first search would visit from `vertex` if it had already
  /// visited the vertices in `visited`.
  /// - Parameters:
  ///   - vertex: The vertex from which the depth-first search starts
  ///   - visited: The vertices that were already visited
  /// - Returns: The next vertex or nil if there is none
  func nextVertexInDepthFirstSearch(
    startingFrom vertex: V,
    withVisited visited: Set<V>
  ) -> V? {
    guard visited.contains(vertex),
      let neighbours = graph.neighbours(of: vertex, in: traverseDirection)
    else {
      return nil
    }

    return neighbours.first(where: { !visited.contains($0) })
  }
}
