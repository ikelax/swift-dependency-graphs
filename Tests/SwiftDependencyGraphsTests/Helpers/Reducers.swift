/// Appends `vertex` to the list of `visited` vertices.
func appendReducer<T>(visited: [T], vertex: T) -> [T] {
  var visited = visited
  visited.append(vertex)
  return visited
}

/// Adds the `id` of `vertex` to `sum`.
/// - Parameters:
///   - sum: The original sum value.
///   - vertex: The vertex with the `id` to add to `sum`.
/// - Returns: The new sum which is `sum + vertex.id`.
func addVertexId(sum: Int, vertex: Vertex) -> Int {
  return sum + vertex.id
}
