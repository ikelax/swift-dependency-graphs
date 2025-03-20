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

  @Test("returns that the removal was successful and the removed vertex") func success() {
    #expect(result == .success(.init(vertex: vertex, outgoingEdges: [], incomingEdges: [])))
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

    @Test("returns that the removal was successful, the removed vertex and no edges because there weren't any")
    func success() {
      #expect(result == .success(.init(vertex: vertex, outgoingEdges: [], incomingEdges: [])))
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

    @Test("returns that the removal was successful and the removed vertex and edges", .disabled("This is a know bug."))
    func success() {
      #expect(result == .success(.init(vertex: vertex, outgoingEdges: [], incomingEdges: [])))
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

@Suite("Removing a vertex twice") struct TryRemoveVertexTwiceTests {

  var graph = TestGraph.oneVertex()
  let vertex = vertex1
  let result: DependencyGraph<Vertex>.RemoveVertexResult

  init() {
    _ = graph.remove(vertex: vertex)
    result = graph.remove(vertex: vertex)
  }

  @Test("returns that the removal failed and the vertex that could not be found") func returnsVertex() {
    #expect(result == .failure(.notInGraph(vertex)))
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

@Suite("Failing to remove a vertex") struct RemoveVertexNotInGraphFailedTests {

  var graph = TestGraph.binaryTree()
  let vertex = vertex8
  let result: DependencyGraph<Vertex>.RemoveVertexResult

  init() {
    result = graph.remove(vertex: vertex)
  }

  @Test("returns that the removal failed because the vertex was not in the graph") func success() {
    #expect(result == .failure(.notInGraph(vertex)))
  }

  @Test("does not change the incoming edges") func incomingEdges() {
    #expect(
      graph.incomingEdges == TestGraph.binaryTree().incomingEdges
    )
  }

  @Test("does not change the outgoing edges") func outgoingEdges() {
    #expect(
      graph.outgoingEdges == TestGraph.binaryTree().outgoingEdges
    )
  }

  @Test("does not change the vertices") func vertices() {
    #expect(graph.vertices == TestGraph.binaryTree().vertices)
  }
}
