import Testing

@testable import DependencyGraphs

@Suite("DFS on cycle finds the starting") struct DfsFirstWhereFindsStartingVertexTests {
  let cycle = TestGraph.cycle()

  @Test("vertex 1") func findsVertexWithId1() {
    #expect(
      cycle.depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [],
        firstWhere: { (_: Vertex) -> Bool in true })
        == vertex1)
  }

  @Test("vertex 2") func findsVertexWithId2() {
    #expect(
      cycle.depthFirstSearchImpl(
        startingFrom: vertex2, in: .forwards, withVisited: [],
        firstWhere: { (_: Vertex) -> Bool in true })
        == vertex2)
  }

  @Test("vertex 3") func findsVertexWithId3() {
    #expect(
      cycle.depthFirstSearchImpl(
        startingFrom: vertex3, in: .forwards, withVisited: [],
        firstWhere: { (_: Vertex) -> Bool in true })
        == vertex3)
  }

  @Test("vertex 4") func findsVertexWithId4() {
    #expect(
      cycle.depthFirstSearchImpl(
        startingFrom: vertex4, in: .forwards, withVisited: [],
        firstWhere: { (_: Vertex) -> Bool in true })
        == vertex4)
  }
}
