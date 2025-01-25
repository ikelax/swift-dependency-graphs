import Testing

@Suite("Sequence: for-in")
struct ForInTests {
  @Test("directed circle graph") func directedC4() async throws {
    var ids: [Int] = []
    for vertex in TestGraph.directedC4() {
      ids.append(vertex.id)
    }

    #expect(ids == [1, 2, 3, 4])
  }
}
