import Testing

@testable import DependencyGraphs

@Suite("the empty graph") struct ContainsVertexWithTests {

  @Test("does not contain the vertex v") func notVertexV() {
    #expect(TestGraph.empty.contains(vertex: vertex1) == false)
  }

  @Test("does not contain a vertex with an even id") func notEvenId() {
    #expect(
      TestGraph.empty.contains(vertexWith: { vertexInGraph in vertexInGraph.id.isMultiple(of: 2)
      }) == false
    )
  }

  @Test("does not contain a vertex with a label that starts with a") func notLabelA() {
    #expect(
      TestGraph.empty.contains(vertexWith: { vertexInGraph in
        vertexInGraph.label.starts(with: "a")
      }) == false
    )
  }
}
