import Testing

@testable import DependencyGraphs

@Suite("A binary tree") struct BecomesCyclicWithBinaryTreeTests {

  @Test("becomes cyclic if (5, 1) is added") func addEdges51() {
    #expect(
      TestGraph.binaryTree().becomesCyclicWith(edge: (vertex5, vertex1)) == true)
  }

  @Test("does not become cyclic if (1, 5) is added") func addEdges15() {
    #expect(
      TestGraph.binaryTree().becomesCyclicWith(edge: (vertex1, vertex5)) == false)
  }
}
