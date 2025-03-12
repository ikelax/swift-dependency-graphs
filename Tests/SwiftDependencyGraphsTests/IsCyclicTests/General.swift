import Testing

@testable import DependencyGraphs

@Suite("") struct IsCyclicWithTests {
  let path = TestGraph.path()

  @Test("graph is not cyclic if an already existing edge is added") func nothingIsChanged() {
    #expect(path.isCyclicWith(edge: (vertex1, vertex2)) == false)
  }

  @Test("graph does not change if it would be cyclic") func doesNotChangeIfIsCyclic() {
    let graph = path
    _ = graph.isCyclicWith(edge: (vertex5, vertex1))
    #expect(graph.vertices == TestGraph.path().vertices)
  }

  @Test("graph does not change if it would not be cyclic")
  func doesNotChangeIfNotBecomesCyclic() {
    let graph = path
    _ = graph.isCyclicWith(edge: (vertex1, vertex5))
    #expect(graph.vertices == TestGraph.path().vertices)
  }
}
