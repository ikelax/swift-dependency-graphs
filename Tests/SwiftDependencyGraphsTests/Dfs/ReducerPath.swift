import Testing

@testable import DependencyGraphs

@Suite("DFS on path starting from vertex 1") struct DfsReducerPathTests {
  @Suite("visits all vertices") struct MethodTests {
    @Test("with the public method") func dfs() {
      #expect(
        TestGraph.path().depthFirstSearch(
          startingFrom: vertex1, in: .forwards, reduceWith: appendReducer, withInitialValue: []
        )
          == [vertex1, vertex2, vertex3, vertex4, vertex5])
    }

    @Test("with the private method") func dfsImpl() {
      #expect(
        TestGraph.path().depthFirstSearchImpl(
          startingFrom: vertex1, in: .forwards, withVisited: [], reduceWith: appendReducer,
          withInitialValue: [])
          == [vertex1, vertex2, vertex3, vertex4, vertex5])
    }
  }

  @Test("stops at 2 because 3 was already discovered") func stops() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [vertex3],
        reduceWith: appendReducer, withInitialValue: [])
        == [vertex1, vertex2])
  }

  @Test("visits no vertices because all were already discovered") func allDiscovered() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards,
        withVisited: [vertex1, vertex2, vertex3, vertex4, vertex5],
        reduceWith: appendReducer, withInitialValue: emptyVertexList)
        == [])
  }

  @Test("visits no vertices because 1 was already discovered") func nextDiscovered() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [vertex1],
        reduceWith: appendReducer, withInitialValue: emptyVertexList)
        == [])
  }
}

@Suite("DFS on path starting from vertex 1 in backwards direction") struct BackwardsDfsReducerPathTests {
  @Suite("visits all vertices") struct MethodTests {
    @Test("with the public method") func dfs() {
      #expect(
        TestGraph.path().depthFirstSearch(
          startingFrom: vertex5, in: .backwards, reduceWith: appendReducer, withInitialValue: []
        )
          == [vertex5, vertex4, vertex3, vertex2, vertex1])
    }

    @Test("with the private method") func dfsImpl() {
      #expect(
        TestGraph.path().depthFirstSearchImpl(
          startingFrom: vertex5, in: .backwards, withVisited: [], reduceWith: appendReducer,
          withInitialValue: [])
          == [vertex5, vertex4, vertex3, vertex2, vertex1])
    }
  }

  @Test("stops at 3 because 2 was already discovered") func stops() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex5, in: .backwards, withVisited: [vertex2],
        reduceWith: appendReducer, withInitialValue: [])
        == [vertex5, vertex4, vertex3])
  }

  @Test("visits no vertices because all were already discovered") func allDiscovered() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex5, in: .backwards,
        withVisited: [vertex1, vertex2, vertex3, vertex4, vertex5],
        reduceWith: appendReducer, withInitialValue: emptyVertexList)
        == [])
  }

  @Test("visits no vertices because 5 was already discovered") func nextDiscovered() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex5, in: .backwards, withVisited: [vertex5],
        reduceWith: appendReducer, withInitialValue: emptyVertexList)
        == [])
  }
}
