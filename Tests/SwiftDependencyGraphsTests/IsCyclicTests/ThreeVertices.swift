import Testing

@testable import DependencyGraphs

@Suite("A graph with three vertices") struct IsCyclicWithThreeVerticesTests {

  @Test("is cyclic with (1, 2) and (2, 1)") func addEdges12And21() {
    #expect(
      TestGraph.threeVertices().isCyclicWith(
        edge: (vertex1, vertex2)) == false)

    var graph = TestGraph.threeVertices()
    _ = graph.incomingEdges[vertex2.id]?.unordered.insert(vertex1)
    _ = graph.outgoingEdges[vertex1.id]?.unordered.insert(vertex2)

    #expect(
      graph.isCyclicWith(
        edge: (vertex2, vertex1)) == true)
  }

  @Test("is cyclic with (1, 4) and (4, 1)") func addEdge14And41() {
    #expect(
      TestGraph.threeVertices().isCyclicWith(
        edge: (vertex1, vertex4)) == false)

    var graph = TestGraph.threeVertices()
    _ = graph.vertices.insert(vertex4)
    graph.incomingEdges[vertex4.id] = [vertex1]
    graph.outgoingEdges[vertex4.id] = []
    _ = graph.outgoingEdges[vertex1.id]?.unordered.insert(vertex4)

    #expect(
      graph.isCyclicWith(
        edge: (vertex4, vertex1)) == true)
  }

  @Test("is not cyclic with (1, 2) and (3, 1)") func addEdges12And31() {
    #expect(
      TestGraph.threeVertices().isCyclicWith(
        edge: (vertex1, vertex2)) == false)

    var graph = TestGraph.threeVertices()
    _ = graph.incomingEdges[vertex2.id]?.unordered.insert(vertex1)
    _ = graph.outgoingEdges[vertex1.id]?.unordered.insert(vertex2)

    #expect(
      graph.isCyclicWith(
        edge: (vertex3, vertex1)) == false)

  }
}
