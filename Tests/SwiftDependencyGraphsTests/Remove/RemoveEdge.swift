import Testing

@testable import DependencyGraphs

@Suite("Removes edge from graph and") struct RemoveEdgeSuccessfullyTests {

  var graph = TestGraph.path()
  let edge = (vertex1, vertex2)
  let result: (Vertex, Vertex)?

  init() {
    result = graph.remove(edge: edge)
  }

  @Test("returns the edge") func returnsEdge() {
    #expect(result.unsafelyUnwrapped == edge)
  }

  @Test("the incoming edges are modified") func incomingEdges() {
    #expect(
      graph.incomingEdges == [
        vertex1.id: [],
        vertex2.id: [],
        vertex3.id: [vertex2],
        vertex4.id: [vertex3],
        vertex5.id: [vertex4],
      ])
  }

  @Test("the outgoing edges are modified") func outgoingEdges() {
    #expect(
      graph.outgoingEdges == [
        vertex1.id: [],
        vertex2.id: [vertex3],
        vertex3.id: [vertex4],
        vertex4.id: [vertex5],
        vertex5.id: [],
      ])
  }

  @Test("the vertices are not modified") func vertices() {
    #expect(graph.vertices == TestGraph.path().vertices)
  }
}

@Suite("Fails to remove edge from graph") struct RemoveEdgeFailedTests {

  var graph = TestGraph.path()

  @Test("because the head vertex does not exist") mutating func headVertex() {
    #expect(graph.remove(edge: (vertex7, vertex2)) == nil)
  }

  @Test("because the tail vertex does not exist") mutating func tailVertex() {
    #expect(graph.remove(edge: (vertex3, vertex6)) == nil)
  }

  @Test("because it is in the opposite direction") mutating func oppositeDirection() {
    #expect(graph.remove(edge: (vertex4, vertex3)) == nil)
  }

  @Test("because the edge is not in the graph") mutating func headEdge() {
    #expect(graph.remove(edge: (vertex2, vertex4)) == nil)
  }

  @Test("because it was already removed") mutating func firstSuccessfulSecondFail() {
    let edge = (vertex1, vertex2)
    graph.remove(edge: edge)
    #expect(graph.remove(edge: edge) == nil)
  }

  @Test("twice") mutating func twiceFail() {
    let edge = (vertex2, vertex5)
    graph.remove(edge: edge)
    #expect(graph.remove(edge: edge) == nil)
  }
}

@Suite("When it fails to remove an edge,") struct NoModificationWhenFailTests {
  var graph = TestGraph.path()

  init() {
    graph.remove(edge: (vertex5, vertex1))
  }

  @Test("the incoming edges are not modified") func incomingEdges() {
    #expect(
      graph.incomingEdges == TestGraph.path().incomingEdges)
  }

  @Test("the outgoing edges are not modified") func outgoingEdges() {
    #expect(
      graph.outgoingEdges == TestGraph.path().outgoingEdges)
  }

  @Test("the vertices are not modified") func vertices() {
    #expect(graph.vertices == TestGraph.path().vertices)
  }
}
