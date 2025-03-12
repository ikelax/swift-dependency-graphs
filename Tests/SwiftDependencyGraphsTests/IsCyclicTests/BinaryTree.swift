import Testing

@testable import DependencyGraphs

@Suite("A binary tree") struct IsCyclicWithBinaryTreeTests {
  let binaryTree = TestGraph.binaryTree()

  @Test("is cyclic with (5, 1)") func addEdges51() {
    #expect(
      binaryTree.isCyclicWith(edge: (vertex5, vertex1)) == true)
  }

  @Test("is not cyclic with (1, 5)") func addEdges15() {
    #expect(
      binaryTree.isCyclicWith(edge: (vertex1, vertex5)) == false)
  }
}
