import Testing

@testable import DependencyGraphs

@Suite("A path with five vertices") struct IsCyclicWithPathTests {
  let path = TestGraph.path()

  @Test("is cyclic with (5, 1)") func addEdge51() {
    #expect(path.isCyclicWith(edge: (vertex5, vertex1)) == true)
  }

  @Test("is cyclic with (5, 2)") func addEdge52() {
    #expect(path.isCyclicWith(edge: (vertex5, vertex2)) == true)
  }

  @Test("is not cyclic with (1, 5)") func addEdge15() {
    #expect(path.isCyclicWith(edge: (vertex1, vertex5)) == false)
  }

  @Test("is not cyclic with (5, 6)") func addEdge56() {
    #expect(path.isCyclicWith(edge: (vertex5, vertex6)) == false)
  }

  @Test("is not cyclic with (6, 1)") func addEdge61() {
    #expect(path.isCyclicWith(edge: (vertex6, vertex1)) == false)
  }

  @Test("is not cyclic with (1, 6)") func addEdge16() {
    #expect(
      path.isCyclicWith(edge: (vertex1, vertex6)) == false)
  }
}
