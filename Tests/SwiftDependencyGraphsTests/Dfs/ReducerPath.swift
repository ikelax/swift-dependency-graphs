import Testing

@testable import DependencyGraphs

@Suite("starting from vertex 1 in forwards direction") struct DfsReducerPathTests {
  @Suite("visits all vertices") struct VisitAllVerticesTests {
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
