import Testing

@testable import DependencyGraphs

@Suite("A graph with three vertices") struct BecomesCyclicWithThreeVerticesTests {

  @Test("becomes cyclic if (1, 2) and (2, 1) is added") func addEdges12And21() {
    #expect(TestGraph.threeVertices().becomesCyclicWith(vertices: [], edges:  [(vertex1, vertex2), (vertex2, vertex1)]) == true)
  }
  
  @Test("becomes cyclic if (1, 4) and (4, 1) is added") func addEdge14And41() {
    #expect(TestGraph.threeVertices().becomesCyclicWith(vertices: [vertex4], edges:  [(vertex1, vertex4), (vertex4, vertex1)]) == true)
  }
  
  @Test("does not become cyclic if (1, 2) and (3, 1) is added") func addEdges12And31() {
    #expect(TestGraph.threeVertices().becomesCyclicWith(vertices: [], edges:  [(vertex1, vertex2), (vertex3, vertex1)]) == false)
  }
  
  @Test("does not become cyclic if vertex 4 is added") func addVertex4() {
    #expect(TestGraph.path().becomesCyclicWith(vertices: [vertex4], edges:  []) == false)
  }
}
