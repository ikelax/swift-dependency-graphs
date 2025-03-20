// remove twice
// try remove vertex not in graph
// try remove vertex with tail
// try remove vertex with head
// try remove vertex with tail and head

import Testing

@testable import DependencyGraphs

@Suite("Removing a vertex") struct RemoveVertexSuccessfullyTests {

  var graph = TestGraph.oneVertex()
  let vertex = vertex1
  let result: DependencyGraph<Vertex>.RemoveVertexResult

  init() {
    result = graph.remove(vertex: vertex)
  }
  
  @Test("returns that the removal was successful") func success() {
    #expect(throws: Never.self) {
      try result.get()
    }
  }
  
  @Test("returns the removed vertex") func returnsVertex() {
    #expect(try! result.get().vertex == vertex)
  }

  @Test("does not change the incoming edges") func incomingEdges() {
    #expect(
      graph.incomingEdges == TestGraph.oneVertex().incomingEdges
    )
  }

  @Test("does not change the outgoing edges") func outgoingEdges() {
    #expect(
      graph.outgoingEdges == TestGraph.oneVertex().outgoingEdges
    )
  }

  @Test("changes the vertices") func vertices() {
    #expect(graph.vertices == [:])
  }
}

@Suite("Forced removing a vertex") struct ForcedRemoveVertexSuccessfullyTests {

  @Suite("from the graph with a single vertex") struct OneVertexTests {
    var graph = TestGraph.oneVertex()
    let vertex = vertex1
    let result: DependencyGraph<Vertex>.RemoveVertexResult

    init() {
      result = graph.remove(vertex: vertex, byForce: true)
    }

    @Test("returns that the removal was successful") func success() {
      #expect(throws: Never.self) {
        try result.get()
      }
    }
    
    @Test("returns the removed vertex") func returnsVertex() {
      #expect(try! result.get().vertex == vertex)
    }
    
    @Test("returns no incoming edges because there were not any") func returnsNoIncomingEdges() {
      #expect(try! result.get().incomingEdges == [])
    }
    
    @Test("returns no outgoing edges because there were not any") func returnsNoOutgoingEdges() {
      #expect(try! result.get().outgoingEdges == [])
    }

    @Test("does not change the incoming edges", .disabled("This is a know bug.")) func incomingEdges() {
      #expect(
        graph.incomingEdges == TestGraph.oneVertex().incomingEdges
      )
    }

    @Test("does not change the outgoing edges", .disabled("This is a know bug.")) func outgoingEdges() {
      #expect(
        graph.outgoingEdges == TestGraph.oneVertex().outgoingEdges
      )
    }

    @Test("changes the vertices") func vertices() {
      #expect(graph.vertices == [:])
    }
  }
  
  @Suite("from the graph with a path") struct PathTests {
    var graph = TestGraph.path()
    let vertex = vertex2
    let result: DependencyGraph<Vertex>.RemoveVertexResult

    init() {
      result = graph.remove(vertex: vertex, byForce: true)
    }

    @Test("returns that the removal was successful") func success() {
      #expect(throws: Never.self) {
        try result.get()
      }
    }
    
    @Test("returns the removed vertex") func returnsVertex() {
      #expect(try! result.get().vertex == vertex)
    }
    
    @Test("returns the removed incoming edges", .disabled("This is a know bug.")) func returnsIncomingEdges() {
      #expect(try! result.get().incomingEdges == [])
    }
    
    @Test("returns the removed outgoing edges", .disabled("This is a know bug.")) func returnsOutgoingEdges() {
      #expect(try! result.get().outgoingEdges == [])
    }

    @Test("changes the incoming edges", .disabled("This is a know bug.")) func incomingEdges() {
      #expect(
        graph.incomingEdges == [
          vertex1.id: [],
          vertex3.id: [],
          vertex4.id: [vertex3],
          vertex5.id: [vertex4],
        ]
      )
    }

    @Test("changes the outgoing edges", .disabled("This is a know bug.")) func outgoingEdges() {
      #expect(
        graph.outgoingEdges == [
          vertex1.id: [],
          vertex3.id: [vertex4],
          vertex4.id: [vertex5],
          vertex5.id: [],
        ]
      )
    }

    @Test("changes the vertices") func vertices() {
      #expect(
        graph.vertices == [
        vertex1.id: vertex1,
        vertex3.id: vertex3,
        vertex4.id: vertex4,
        vertex5.id: vertex5,
      ]
      )
    }
  }
}
