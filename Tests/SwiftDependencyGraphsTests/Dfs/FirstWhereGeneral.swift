import Testing

@testable import DependencyGraphs

@Suite("Depth-first search always finds the starting vertex") struct AlwaysFindsStartingVertexTests
{
  @Test("for vertex 1") func findsVertexWithId1() {
    #expect(
      TestGraph.directedC4().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [],
        firstWhere: { (_: Vertex) -> Bool in true })
        == vertex1)
  }

  @Test("for vertex 2") func findsVertexWithId2() {
    #expect(
      TestGraph.directedC4().depthFirstSearchImpl(
        startingFrom: vertex2, in: .forwards, withVisited: [],
        firstWhere: { (_: Vertex) -> Bool in true })
        == vertex2)
  }

  @Test("for vertex 3") func findsVertexWithId3() {
    #expect(
      TestGraph.directedC4().depthFirstSearchImpl(
        startingFrom: vertex3, in: .forwards, withVisited: [],
        firstWhere: { (_: Vertex) -> Bool in true })
        == vertex3)
  }

  @Test("for vertex 4") func findsVertexWithId4() {
    #expect(
      TestGraph.directedC4().depthFirstSearchImpl(
        startingFrom: vertex4, in: .forwards, withVisited: [],
        firstWhere: { (_: Vertex) -> Bool in true })
        == vertex4)
  }
}
