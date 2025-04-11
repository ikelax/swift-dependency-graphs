import Testing

@testable import DependencyGraphs

@Suite("Inserting a vertex") struct InsertVertexTests {

  @Suite("with a unique ID and unique label") struct UniqueIdAndLabelTests {
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

  @Suite("with a unique ID and existing label") struct UniqueIdAndExistingLabelTests {
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

  @Suite("twice") struct TwiceTests {
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

  @Suite("with an existing ID and unique label") struct ExistingIdAndUniqueLabelTests {
    var graph = TestGraph.path()
    let newVertex = Vertex(id: 5, label: "unique")
    let result: (Bool, Vertex)

    init() {
      result = graph.insert(newVertex: newVertex)
    }

    @Test("returns that the insertion failed and the existing vertex with a different label") func returnValue() {
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

  @Suite("with an existing ID and label") struct ExistingIdAndLabelTests {
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

}
