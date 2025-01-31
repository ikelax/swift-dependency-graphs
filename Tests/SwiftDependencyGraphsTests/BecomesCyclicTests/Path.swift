import Testing

@testable import DependencyGraphs

@Suite("A path with five vertices") struct BecomesCyclicWithPathTests {

  @Test("becomes cyclic if (5, 1) is added") func addEdge51() {
    #expect(TestGraph.path().becomesCyclicWith(vertices: [], edges:  [(vertex5, vertex1)]) == true)
  }
  
  @Test("does not become cyclic if (1, 5) is added") func addEdge15() {
    #expect(TestGraph.path().becomesCyclicWith(vertices: [], edges:  [(vertex1, vertex5)]) == false)
  }
  
  @Test("does not become cyclic if vertex 6 is added") func addVertex6() {
    #expect(TestGraph.path().becomesCyclicWith(vertices: [vertex6], edges:  []) == false)
  }
  
  @Test("becomes cyclic if vertex 6 and (5, 1) is added") func addVertex6AndEdge51() {
    #expect(TestGraph.path().becomesCyclicWith(vertices: [vertex6], edges:  [(vertex5, vertex1)]) == true)
  }
  
  @Test("does not become cyclic if vertex 6 and (1, 5) is added") func addVertex6AndEdge15() {
    #expect(TestGraph.path().becomesCyclicWith(vertices: [vertex6], edges:  [(vertex1, vertex5)]) == false)
  }
}

