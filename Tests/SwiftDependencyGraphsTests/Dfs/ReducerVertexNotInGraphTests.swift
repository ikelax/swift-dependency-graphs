import Testing

@Suite("If the vertex is not in the graph,") struct ReducerVertexNotInGraphTests {
  let graph = TestGraph.binaryTree()
  let vertexNotInGraph = Vertex(id: -1, label: "not-in-graph")

  @Test("DFS reduces to the accumulator for forwards direction") func forwards() {
    #expect(
      graph.depthFirstSearch(
        startingFrom: vertexNotInGraph, in: .forwards, reduceWith: addReducer, withInitialValue: 0
      ) == 0
    )
  }

  @Test("DFS reduces to the accumulator for backwards direction") func backwards() {
    #expect(
      graph.depthFirstSearch(
        startingFrom: vertexNotInGraph, in: .backwards, reduceWith: addReducer, withInitialValue: 0
      ) == 0
    )
  }
}
