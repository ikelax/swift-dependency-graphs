import Testing

@testable import DependencyGraphs

@Suite("Two disconnected components") struct BecomesCyclicWithTwoDisconnectedComponentsTests {

  @Test("become cyclic") func addEdges23And51() {
    #expect(TestGraph.threeVertices().becomesCyclicWith(vertices: [], edges:  [(vertex2, vertex3), (vertex5, vertex1)]) == true)
  }
}
