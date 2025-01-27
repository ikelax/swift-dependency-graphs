/// Appends `vertex` to the list of `visited` vertices.
func appendReducer<T>(visited: [T], vertex: T) -> [T] {
  var visited = visited
  visited.append(vertex)
  return visited
}
