import Testing

@testable import DependencyGraphs

@Suite("A cycle graph") struct IsCyclicWithCycleTests {

  @Test("is cyclic") func cycleGraphIsCyclic() {
    #expect(
      TestGraph.cycle().isCyclicWith(edge: (vertex1, vertex2)) == true)
  }
}
