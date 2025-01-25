import Testing

@Suite("Sequence: for-in")
struct ForInTests {
  func traverseTest(graph: TestGraph, expectedIds: [Int]) async throws {
    var ids: [Int] = []
    for vertex in graph {
      ids.append(vertex.id)
    }

    #expect(ids == expectedIds)
  }

  @Test("path") func path() async throws {
    try await traverseTest(graph: TestGraph.path(), expectedIds: [1, 2, 3, 4, 5])
  }

  @Test("directed circle graph") func directedCircleGraph() async throws {
    try await traverseTest(graph: TestGraph.directedC4(), expectedIds: [1, 2, 3, 4])
  }

  @Test("binary tree") func binaryTree() async throws {
    try await traverseTest(graph: TestGraph.binaryTree(), expectedIds: [1, 2, 4, 5, 3, 6, 7])
  }

  @Test("empty graph") func emptyGraph() async throws {
    try await traverseTest(graph: TestGraph.empty, expectedIds: [])
  }

  @Test("three vertices") func threeVertices() async throws {
    try await traverseTest(graph: TestGraph.complementOfK3(), expectedIds: [1, 2, 3])
  }

  @Test("one vertex") func oneVertex() async throws {
    try await traverseTest(graph: TestGraph.oneVertex(), expectedIds: [5])
  }

  @Test("two disconnected components") func twoDisconnectedComponents() async throws {
    try await traverseTest(graph: TestGraph.twoDisconnectedComponents(), expectedIds: [1, 6, 2, 3, 4, 5])
  }
}

@Suite("Sequence: Higher-order functions")
struct HigherOrderTests {
  @Test("filter") func filter() async throws {
    #expect(TestGraph.path().filter({ $0.id % 2 == 0 }) == [vertex2, vertex4])
  }

  @Test("map") func map() async throws {
    #expect(TestGraph.directedC4().map({ $0.id * 3 }) == [3, 6, 9, 12])
  }

  @Test("reduce") func reduce() async throws {
    #expect(TestGraph.directedC4().reduce(0, { result, vertex in vertex.id + result }) == 10)
  }

  @Test("contains") func contains() async throws {
    #expect(TestGraph.path().contains(where: { $0.id == 2 }))
  }
}
