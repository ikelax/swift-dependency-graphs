import Testing

@testable import DependencyGraphs

@Suite("A path with five vertices") struct BecomesCyclicWithPathTests {

  // TODO: With reverse path
  @Test("becomes cyclic if (5, 1) is added") func addEdge51() {
    #expect(TestGraph.path().becomesCyclicWith(edge: (vertex5, vertex1)) == true)
  }

  @Test("does not become cyclic if (1, 5) is added") func addEdge15() {
    #expect(TestGraph.path().becomesCyclicWith(edge: (vertex1, vertex5)) == false)
  }

  @Test("does not become cyclic if (6, 1) is added") func addEdge61() {
    #expect(TestGraph.path().becomesCyclicWith(edge: (vertex6, vertex1)) == false)
  }

  @Test("does not cyclic if (1, 6) is added") func addEdge16() {
    #expect(
      TestGraph.path().becomesCyclicWith(edge: (vertex1, vertex6)) == false)
  }
}
