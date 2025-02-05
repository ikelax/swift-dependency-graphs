import Testing

@testable import DependencyGraphs

@Suite("A graph with three vertices") struct BecomesCyclicWithThreeVerticesTests {

  @Test("becomes cyclic if (1, 2) and (2, 1) are added") func addEdges12And21() {
    #expect(
      TestGraph.threeVertices().becomesCyclicWith(
        edge: (vertex1, vertex2)) == false)

    var graph = TestGraph.threeVertices()
    _ = graph.incomingEdges[vertex2.id]?.unordered.insert(vertex1)
    _ = graph.outgoingEdges[vertex1.id]?.unordered.insert(vertex2)

    #expect(
      graph.becomesCyclicWith(
        edge: (vertex2, vertex1)) == true)
  }

  @Test("becomes cyclic if (1, 4) and (4, 1) are added") func addEdge14And41() {
    #expect(
      TestGraph.threeVertices().becomesCyclicWith(
        edge: (vertex1, vertex4)) == false)

    var graph = TestGraph.threeVertices()
    _ = graph.vertices.insert(vertex4)
    graph.incomingEdges[vertex4.id] = [vertex1]
    graph.outgoingEdges[vertex4.id] = []
    _ = graph.outgoingEdges[vertex1.id]?.unordered.insert(vertex4)

    #expect(
      graph.becomesCyclicWith(
        edge: (vertex4, vertex1)) == true)
  }

  @Test("does not become cyclic if (1, 2) and (3, 1) are added") func addEdges12And31() {
    #expect(
      TestGraph.threeVertices().becomesCyclicWith(
        edge: (vertex1, vertex2)) == false)

    var graph = TestGraph.threeVertices()
    _ = graph.incomingEdges[vertex2.id]?.unordered.insert(vertex1)
    _ = graph.outgoingEdges[vertex1.id]?.unordered.insert(vertex2)

    #expect(
      graph.becomesCyclicWith(
        edge: (vertex3, vertex1)) == false)

  }
}
