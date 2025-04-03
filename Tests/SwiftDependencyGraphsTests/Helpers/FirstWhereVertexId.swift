func firstWhereVertexId(is id: Int) -> ((Vertex) -> Bool) {
  { vertex in vertex.id == id }
}

func firstWhereVertexId(greaterThan id: Int) -> ((Vertex) -> Bool) {
  { vertex in vertex.id > id }
}
