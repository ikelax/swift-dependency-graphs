import Testing

@testable import DependencyGraphs

@Suite("DFS on binary tree") struct DfsFirstWhereBinaryTreeTests {
  @Test("finds a vertex with an id > 4") func findsVertexWithId3() {
    #expect(
      TestGraph.binaryTree().depthFirstSearchImpl(
        startingFrom: vertex1, in: .forwards, withVisited: [],
        firstWhere: firstWhereVertexId(greaterThan: 2))
        == vertex4)
  }
}
