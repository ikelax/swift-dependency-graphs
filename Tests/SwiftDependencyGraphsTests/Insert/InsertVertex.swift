import Testing

@testable import DependencyGraphs

// swiftlint:disable:next line_length
@Suite("Inserting a new vertex with a unique ID and a unique label into the graph") struct InsertVertexSuccessfullyTests {

  var graph = TestGraph.path()
  let newVertex = Vertex(id: 6)
  let result: (Bool, Vertex)

  init() {
    result = graph.insert(newVertex: newVertex)
  }

  @Test("returns that the insertion was successful and the inserted vertex") func returnValue() {
    #expect(result == (true, newVertex))
  }

  @Test("does not change the incoming edges") func incomingEdges() {
    #expect(graph.incomingEdges == TestGraph.path().incomingEdges)
  }

  @Test("does not change the outgoing edges") func outgoingEdges() {
    #expect(graph.outgoingEdges == TestGraph.path().outgoingEdges)
  }

  @Test("changes the vertices") func vertices() {
    #expect(
      graph.vertices == [
        vertex1.id: vertex1,
        vertex2.id: vertex2,
        vertex3.id: vertex3,
        vertex4.id: vertex4,
        vertex5.id: vertex5,
        newVertex.id: newVertex,
      ])
  }
}

// swiftlint:disable:next line_length
@Suite("Inserting a new vertex with a unique ID and an existing label into the graph") struct InsertVertexExistingLabelSuccessfullyTests {

  var graph = TestGraph.path()
  let newVertex = Vertex(id: 6, label: "5")
  let result: (Bool, Vertex)

  init() {
    result = graph.insert(newVertex: newVertex)
  }

  @Test("returns that the insertion was successful and the inserted vertex") func returnValue() {
    #expect(result == (true, newVertex))
  }

  @Test("does not change the incoming edges") func incomingEdges() {
    #expect(graph.incomingEdges == TestGraph.path().incomingEdges)
  }

  @Test("does not change the outgoing edges") func outgoingEdges() {
    #expect(graph.outgoingEdges == TestGraph.path().outgoingEdges)
  }

  @Test("changes the vertices") func vertices() {
    #expect(
      graph.vertices == [
        vertex1.id: vertex1,
        vertex2.id: vertex2,
        vertex3.id: vertex3,
        vertex4.id: vertex4,
        vertex5.id: vertex5,
        newVertex.id: newVertex,
      ])
  }
}

@Suite("Inserting a new vertex twice into the graph") struct InsertVertexTwiceTests {

  var graph = TestGraph.path()
  let newVertex = Vertex(id: -1)
  let result: (Bool, Vertex)

  init() {
    _ = graph.insert(newVertex: newVertex)
    result = graph.insert(newVertex: newVertex)
  }

  @Test("returns that the (second) insertion failed and the existing vertex") func returnValue() {
    #expect(result == (false, newVertex))
  }

  @Test("does not change the incoming edges") func incomingEdges() {
    #expect(graph.incomingEdges == TestGraph.path().incomingEdges)
  }

  @Test("does not change the outgoing edges") func outgoingEdges() {
    #expect(graph.outgoingEdges == TestGraph.path().outgoingEdges)
  }

  @Test("changes the vertices") func vertices() {
    #expect(
      graph.vertices == [
        vertex1.id: vertex1,
        vertex2.id: vertex2,
        vertex3.id: vertex3,
        vertex4.id: vertex4,
        vertex5.id: vertex5,
        newVertex.id: newVertex,
      ])
  }
}

// swiftlint:disable:next line_length
@Suite("Inserting a vertex with existing ID and label into the graph,") struct InsertVertexExistingIdAndLabelFailedTests {

  var graph = TestGraph.path()
  let newVertex = Vertex(id: 5)
  let result: (Bool, Vertex)

  init() {
    result = graph.insert(newVertex: newVertex)
  }

  @Test("returns that the insertion failed and the existing vertex") func returnValue() {
    #expect(result == (false, newVertex))
  }

  @Test("does not change the incoming edges") func incomingEdges() {
    #expect(graph.incomingEdges == TestGraph.path().incomingEdges)
  }

  @Test("does not change the outgoing edges") func outgoingEdges() {
    #expect(graph.outgoingEdges == TestGraph.path().outgoingEdges)
  }

  @Test("does not change the vertices") func vertices() {
    #expect(graph.vertices == TestGraph.path().vertices)
  }
}

// swiftlint:disable:next line_length
@Suite("Inserting a vertex with an existing ID and a unique label into the graph,") struct InsertVertexExistingIdAndUniqueLabelFailedTests {

  var graph = TestGraph.path()
  let newVertex = Vertex(id: 5, label: "unique")
  let result: (Bool, Vertex)

  init() {
    result = graph.insert(newVertex: newVertex)
  }

  @Test("returns that the insertion failed and the existing vertex") func returnValue() {
    #expect(result == (false, Vertex(id: 5)))
  }

  @Test("does not change the incoming edges") func incomingEdges() {
    #expect(graph.incomingEdges == TestGraph.path().incomingEdges)
  }

  @Test("does not change the outgoing edges") func outgoingEdges() {
    #expect(graph.outgoingEdges == TestGraph.path().outgoingEdges)
  }

  @Test("does not change the vertices") func vertices() {
    #expect(graph.vertices == TestGraph.path().vertices)
  }
}
