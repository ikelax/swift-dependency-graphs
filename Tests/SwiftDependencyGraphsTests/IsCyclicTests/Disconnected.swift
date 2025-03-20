import Testing

@testable import DependencyGraphs

@Suite("Two disconnected components") struct IsCyclicWithDisconnectedTests {

  @Test("are cyclic with (2, 3) and (5, 1)") func addEdges23And51() {
    #expect(
      TestGraph.twoDisconnectedComponents().isCyclicWith(
        edge: (vertex2, vertex3)) == false)

    var graph = TestGraph.twoDisconnectedComponents()
    _ = graph.incomingEdges[vertex3.id]?.unordered.insert(vertex2)
    _ = graph.outgoingEdges[vertex2.id]?.unordered.insert(vertex3)

    #expect(
      graph.isCyclicWith(
        edge: (vertex5, vertex1)) == true)
  }
}
