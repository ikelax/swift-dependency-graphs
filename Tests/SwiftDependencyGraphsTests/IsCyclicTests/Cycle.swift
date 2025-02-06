import Testing

@testable import DependencyGraphs

@Suite("A cycle graph") struct IsCyclicWithCycleTests {

  @Test("is cyclic") func cycleGraphIsCyclic() {
    #expect(
      TestGraph.directedC4().isCyclicWith(edge: (vertex1, vertex2)) == true)
  }
}
