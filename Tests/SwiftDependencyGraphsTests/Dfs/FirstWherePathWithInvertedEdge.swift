import Testing

@testable import DependencyGraphs

@Suite("starting from vertex 1") struct StartingFromVertex1Tests {
  @Suite("in forwards direction") struct InForwardsDirection {
    @Test("finds the vertex with id 2") func findsVertexWithId2() {
      #expect(
        TestGraph.path4WithInvertedEdge().depthFirstSearchImpl(
          startingFrom: vertex1, in: .forwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 2))
          == vertex2)
    }

    @Test("does not find the vertex with id 3") func findsNotVertexWithId3() {
      #expect(
        TestGraph.path4WithInvertedEdge().depthFirstSearchImpl(
          startingFrom: vertex1, in: .forwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 3))
          == nil)
    }

    @Test("does not find the vertex with id 4") func findsNotVertexWithId4() {
      #expect(
        TestGraph.path4WithInvertedEdge().depthFirstSearchImpl(
          startingFrom: vertex1, in: .forwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 4))
          == nil)
    }
  }

  @Suite("in backwards direction") struct InBackwardsDirection {
    @Test("does not find the vertex with id 2") func findsVertexWithId2() {
      #expect(
        TestGraph.path4WithInvertedEdge().depthFirstSearchImpl(
          startingFrom: vertex1, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 2))
          == nil)
    }

    @Test("does not find the vertex with id 3") func findsNotVertexWithId3() {
      #expect(
        TestGraph.path4WithInvertedEdge().depthFirstSearchImpl(
          startingFrom: vertex1, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 3))
          == nil)
    }

    @Test("does not find the vertex with id 4") func findsNotVertexWithId4() {
      #expect(
        TestGraph.path4WithInvertedEdge().depthFirstSearchImpl(
          startingFrom: vertex1, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 4))
          == nil)
    }
  }
}

@Suite("starting from vertex 2 in backwards direction") struct StartingFromVertex3Tests {
  @Test("finds the vertex with id 1") func findsNotVertexWithId3() {
    #expect(
      TestGraph.path4WithInvertedEdge().depthFirstSearchImpl(
        startingFrom: vertex2, in: .backwards, withVisited: [],
        firstWhere: firstWhereVertexId(is: 1))
        == vertex1)
  }

  @Test("finds the vertex with id 3") func findsVertexWithId3() {
    #expect(
      TestGraph.path4WithInvertedEdge().depthFirstSearchImpl(
        startingFrom: vertex2, in: .backwards, withVisited: [],
        firstWhere: firstWhereVertexId(is: 3))
        == vertex3)
  }

  @Test("does not find the vertex with id 4") func findsNotVertexWithId4() {
    #expect(
      TestGraph.path4WithInvertedEdge().depthFirstSearchImpl(
        startingFrom: vertex2, in: .backwards, withVisited: [],
        firstWhere: firstWhereVertexId(is: 4))
        == nil)
  }
}
