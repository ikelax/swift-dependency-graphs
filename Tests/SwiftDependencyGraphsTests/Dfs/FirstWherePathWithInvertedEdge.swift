import Testing

@testable import DependencyGraphs

@Suite("DFS on path with inverted edge") struct DfsFirstWherePathWithInvertedEdgeTests {

  @Suite("starting from vertex 1 in forwards direction") struct StartingFromVertex1InForwardsDirectionTests {
    let pathWithInvertedEdge = TestGraph.pathWithInvertedEdge()

    @Test("finds the vertex with id 2") func findsVertexWithId2() {
      #expect(
        pathWithInvertedEdge.depthFirstSearchImpl(
          startingFrom: vertex1, in: .forwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 2))
          == vertex2)
    }

    @Test("does not find the vertex with id 3") func findsNotVertexWithId3() {
      #expect(
        pathWithInvertedEdge.depthFirstSearchImpl(
          startingFrom: vertex1, in: .forwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 3))
          == nil)
    }

    @Test("does not find the vertex with id 4") func findsNotVertexWithId4() {
      #expect(
        pathWithInvertedEdge.depthFirstSearchImpl(
          startingFrom: vertex1, in: .forwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 4))
          == nil)
    }
  }

  @Suite("starting from vertex 1 in backwards direction") struct StartingFromVertex1InBackwardsDirectionTests {
    let pathWithInvertedEdge = TestGraph.pathWithInvertedEdge()

    @Test("does not find the vertex with id 2") func findsVertexWithId2() {
      #expect(
        pathWithInvertedEdge.depthFirstSearchImpl(
          startingFrom: vertex1, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 2))
          == nil)
    }

    @Test("does not find the vertex with id 3") func findsNotVertexWithId3() {
      #expect(
        pathWithInvertedEdge.depthFirstSearchImpl(
          startingFrom: vertex1, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 3))
          == nil)
    }

    @Test("does not find the vertex with id 4") func findsNotVertexWithId4() {
      #expect(
        pathWithInvertedEdge.depthFirstSearchImpl(
          startingFrom: vertex1, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 4))
          == nil)
    }
  }

  @Suite("starting from vertex 2 in backwards direction") struct StartingFromVertex2InBackwardsDirectionTests {
    let pathWithInvertedEdge = TestGraph.pathWithInvertedEdge()

    @Test("finds the vertex with id 1") func findsNotVertexWithId3() {
      #expect(
        pathWithInvertedEdge.depthFirstSearchImpl(
          startingFrom: vertex2, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 1))
          == vertex1)
    }

    @Test("finds the vertex with id 3") func findsVertexWithId3() {
      #expect(
        pathWithInvertedEdge.depthFirstSearchImpl(
          startingFrom: vertex2, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 3))
          == vertex3)
    }

    @Test("does not find the vertex with id 4") func findsNotVertexWithId4() {
      #expect(
        pathWithInvertedEdge.depthFirstSearchImpl(
          startingFrom: vertex2, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 4))
          == nil)
    }
  }
}
