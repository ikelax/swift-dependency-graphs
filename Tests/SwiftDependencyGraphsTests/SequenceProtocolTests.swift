import Testing

@Suite("Sequence: for-in")
struct ForInTests {
    @Test func directedC4() async throws {
        let ids: [Int] = []
        for vertex in TestGraph.directedC4() {
            ids.append(vertex.id)
        }
        
        #expect(ids == [1, 2, 3, 4])
    }
}
