import Testing

@testable import DependencyGraphs

@Suite("C4 with vertices v1, v2, v3 and v4") struct C4ContainsVertexTests {
  @Test("contains the vertex v1") func v1() {
    #expect(TestGraph.directedC4().contains(vertex: vertex1) == true)
  }

  @Test("does not contain the vertex v5") func notV5() {
    #expect(TestGraph.directedC4().contains(vertex: vertex5) == false)
  }

  @Test("contains the vertex v1' with v1' ≠ v1 and v1'.id = v1.id") func id1() {
    let vertexWithId1 = Vertex(id: vertex1.id, label: "not 1")
    #expect(TestGraph.directedC4().contains(vertex: vertexWithId1) == true)
  }

  @Test("does not contain the vertex v1' with v1' ≠ v1 and v1'.label = v1.label") func notLabel1() {
    // C4 has only vertices with the ids 1, 2, 3 and 4.
    let vertexWithLabel1 = Vertex(id: 5, label: "1")
    #expect(TestGraph.directedC4().contains(vertex: vertexWithLabel1) == false)
  }
}
