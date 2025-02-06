import Testing

@testable import DependencyGraphs

@Suite("A path with five vertices") struct IsCyclicWithPathTests {

  // TODO: With reverse path
  @Test("is cyclic with (5, 1)") func addEdge51() {
    #expect(TestGraph.path().isCyclicWith(edge: (vertex5, vertex1)) == true)
  }

  @Test("is not cyclic with (1, 5)") func addEdge15() {
    #expect(TestGraph.path().isCyclicWith(edge: (vertex1, vertex5)) == false)
  }

  @Test("is not cyclic with (6, 1)") func addEdge61() {
    #expect(TestGraph.path().isCyclicWith(edge: (vertex6, vertex1)) == false)
  }

  @Test("is not cyclic with (1, 6)") func addEdge16() {
    #expect(
      TestGraph.path().isCyclicWith(edge: (vertex1, vertex6)) == false)
  }
}
