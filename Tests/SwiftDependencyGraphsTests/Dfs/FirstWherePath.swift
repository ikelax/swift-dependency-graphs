import Testing

@testable import DependencyGraphs

@Suite("starting from vertex 1 in forwards direction") struct ForwardsDfsFirstWherePathTests {
  @Suite("finds a vertex with id 4") struct FindVertexWithId4Tests {
    @Test("with the public method") func dfs() {
      #expect(
        TestGraph.path().depthFirstSearch(
          startingFrom: vertex1, in: .forwards, firstWhere: firstWhereVertexId(is: 3)
        )
          == vertex3)
    }

    @Test("with the private method") func findsVertexWithId4() {
      #expect(
        TestGraph.path().depthFirstSearchImpl(
          startingFrom: vertex1, in: .forwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 4))
          == vertex4)
    }
  }

  @Test("stops at 2 because 3 was already visited") func stops() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [vertex3],
        firstWhere: firstWhereVertexId(is: 4))
        == nil)
  }

  @Test("does not find a vertex because all were already visited") func allVisited() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards,
        withVisited: [vertex1, vertex2, vertex3, vertex4, vertex5],
        firstWhere: firstWhereVertexId(is: 4))
        == nil)
  }

  @Test("does not find a vertex because 1 was already visited") func nextVisited() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [vertex1],
        firstWhere: firstWhereVertexId(is: 1))
        == nil)
  }

  @Test("does not find a vertex with id 6 because none exists") func noVertexWithId5() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [],
        firstWhere: firstWhereVertexId(is: 6))
        == nil)
  }

  @Test("finds a vertex with id 1") func findsVertexWithId1() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [],
        firstWhere: firstWhereVertexId(is: 1))
        == vertex1)
  }

  @Test("finds a vertex with id 2") func findsVertexWithId2() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [],
        firstWhere: firstWhereVertexId(is: 2))
        == vertex2)
  }

  @Test("finds a vertex with id 3") func findsVertexWithId3() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [],
        firstWhere: firstWhereVertexId(is: 3))
        == vertex3)
  }

  @Test("finds a vertex with id 5") func findsVertexWithId5() {
    #expect(
      TestGraph.path().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [],
        firstWhere: firstWhereVertexId(is: 5))
        == vertex5)
  }
}

@Suite("in backwards direction") struct BackwardsDfsFirstWherePathTests {
  @Suite("does not find a vertex with an id > 1 starting from vertex 1") struct MethodTests {
    @Test("with public method") func notFindingVertexPublic() {
      #expect(
        TestGraph.path().depthFirstSearch(
          startingFrom: vertex1, in: .backwards,
          firstWhere: firstWhereVertexId(greaterThan: 1))
          == nil)
    }
    
    @Test("with implementation method") func notFindingVertexImpl() {
      #expect(
        TestGraph.path().depthFirstSearchImpl(
          startingFrom: vertex1, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(greaterThan: 1))
          == nil)
    }
  }

  @Suite("starting from vertex 5") struct FindsVertex {
    @Test("finds vertex with id 3") func findsVertexWithId3() {
      #expect(
        TestGraph.path().depthFirstSearchImpl(
          startingFrom: vertex5, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 3))
          == vertex3)
    }

    @Test("finds vertex with id 4") func findsVertexWithId4() {
      #expect(
        TestGraph.path().depthFirstSearchImpl(
          startingFrom: vertex5, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 4))
          == vertex4)
    }

    @Test("finds vertex with id 1") func findsVertexWithId1() {
      #expect(
        TestGraph.path().depthFirstSearchImpl(
          startingFrom: vertex5, in: .backwards, withVisited: [],
          firstWhere: firstWhereVertexId(is: 1))
          == vertex1)
    }

    @Test("finds vertex with complex predicate") func findsVertexWithPredicate() {
      #expect(
        TestGraph.path().depthFirstSearchImpl(
          startingFrom: vertex5, in: .backwards, withVisited: [],
          firstWhere: { $0.id > 1 && $0.id < 3 })
          == vertex2)
    }
  }
}
