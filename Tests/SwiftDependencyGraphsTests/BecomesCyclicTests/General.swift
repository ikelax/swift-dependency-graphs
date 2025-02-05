import Testing

@testable import DependencyGraphs

@Suite("") struct BecomesCyclicWithTests {

  @Test("graph does not become cyclic if an already existing edge is added") func nothingIsChanged()
  {
    #expect(TestGraph.path().becomesCyclicWith(edge: (vertex1, vertex2)) == false)
  }

  @Test("graph does not change if it would become cyclic") func doesNotChangeIfBecomesCyclic() {
    let graph = TestGraph.path()
    _ = graph.becomesCyclicWith(edge: (vertex5, vertex1))
    #expect(graph.vertices == TestGraph.path().vertices)
  }

  @Test("graph does not change if it would not become cyclic")
  func doesNotChangeIfNotBecomesCyclic() {
    let graph = TestGraph.path()
    _ = graph.becomesCyclicWith(edge: (vertex1, vertex5))
    #expect(graph.vertices == TestGraph.path().vertices)
  }
}
