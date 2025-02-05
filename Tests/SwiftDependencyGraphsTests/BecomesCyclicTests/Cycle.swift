import Testing

@testable import DependencyGraphs

@Suite("A cycle graph") struct BecomesCyclicWithCycleTests {

  @Test("is cyclic") func cycleGraphIsCyclic() {
    #expect(
      TestGraph.directedC4().becomesCyclicWith(edge: (vertex1, vertex2)) == true)
  }
}
