import DependencyGraphs
import Testing

@Suite("The cycle graph") struct ContainsEdgeTests {

  @Suite("contains the edge") struct ContainsTests {
    @Test("(v3, v4)") func v3v4() {
      #expect(TestGraph.directedC4().contains(edge: (vertex3, vertex4)) == true)
    }

    @Test("(v2', v3) with v2' ≠ v2 and v2'.id = v2.id") func headId2() {
      let vertexWithId2 = Vertex(id: vertex2.id, label: "not 2")
      #expect(TestGraph.directedC4().contains(edge: (vertexWithId2, vertex3)) == true)
    }

    @Test("(v3, v4') with v4' ≠ v4 and v4'.id = v4.id") func tailId4() {
      let vertexWithId4 = Vertex(id: vertex4.id, label: "not 4")
      #expect(TestGraph.directedC4().contains(edge: (vertex3, vertexWithId4)) == true)
    }

    @Test("(v1', v2') with v1' ≠ v1 and v1'.id = v1.id and v2' ≠ v2 and v2'.id = v2.id") func headId1AndTailId2() {
      let vertexWithId1 = Vertex(id: vertex1.id, label: "not 1")
      let vertexWithId2 = Vertex(id: vertex2.id, label: "not 2")
      #expect(TestGraph.directedC4().contains(edge: (vertexWithId1, vertexWithId2)) == true)
    }
  }

  @Suite("does not contain the edge") struct DoesNotContainTests {
    @Test("(v4, v2)") func notV4V2() {
      #expect(TestGraph.directedC4().contains(edge: (vertex4, vertex2)) == false)
    }

    @Test("(v1', v2) with v1' ≠ v1 and v1'.label = v1.label") func notHeadLabel1() {
      // C4 has only vertices with the ids 1, 2, 3 and 4.
      let vertexWithLabel1 = Vertex(id: 5, label: "1")
      #expect(TestGraph.directedC4().contains(edge: (vertexWithLabel1, vertex2)) == false)
    }

    @Test("(v5, v1') with v1' ≠ v1 and v1'.label = v1.label") func notTailLabel1() {
      // C4 has only vertices with the ids 1, 2, 3 and 4.
      let vertexWithLabel1 = Vertex(id: 10, label: "1")
      #expect(TestGraph.directedC4().contains(edge: (vertex5, vertexWithLabel1)) == false)
    }

    @Test(
      "(v2', v3') with v2' ≠ v2 and v2'.label = v2.label and v3' ≠ v3 and v3'.label = v3.label"
    ) func notHeadLabel2TailLabel3() {
      // C4 has only vertices with the ids 1, 2, 3 and 4.
      let vertexWithLabel2 = Vertex(id: 12, label: "2")
      let vertexWithLabel3 = Vertex(id: 33, label: "3")
      #expect(TestGraph.directedC4().contains(edge: (vertexWithLabel2, vertexWithLabel3)) == false)
    }
  }
}
