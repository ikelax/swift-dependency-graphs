import Testing

@testable import DependencyGraphs

@Suite("Cycle with vertices v1 to v4") struct CycleContainsVertexTests {
  let cycle = TestGraph.cycle()

  @Test("contains the vertex v1") func v1() {
    #expect(cycle.contains(vertex: vertex1) == true)
  }

  @Test("does not contain the vertex v5") func notV5() {
    #expect(cycle.contains(vertex: vertex5) == false)
  }

  @Test("contains the vertex v1' with v1' ≠ v1 and v1'.id = v1.id") func id1() {
    let vertexWithId1 = Vertex(id: vertex1.id, label: "not 1")
    #expect(cycle.contains(vertex: vertexWithId1) == true)
  }

  @Test("does not contain the vertex v1' with v1' ≠ v1 and v1'.label = v1.label") func notLabel1() {
    // Cycle has only vertices with the ids 1, 2, 3 and 4.
    let vertexWithLabel1 = Vertex(id: 5, label: "1")
    #expect(cycle.contains(vertex: vertexWithLabel1) == false)
  }
}
