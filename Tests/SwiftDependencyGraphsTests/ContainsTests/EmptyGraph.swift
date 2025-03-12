import Testing

@testable import DependencyGraphs

@Suite("The empty graph") struct EmptyGraphContainsTests {
  let emptyGraph = TestGraph.empty

  @Test("does not contain the vertex v") func notVertexV() {
    #expect(emptyGraph.contains(vertex: vertex1) == false)
  }

  @Test("does not contain a vertex with an even id") func notEvenId() {
    #expect(
      emptyGraph.contains(vertexWith: { vertexInGraph in vertexInGraph.id.isMultiple(of: 2)
      }) == false
    )
  }

  @Test("does not contain a vertex with a label that starts with a") func notLabelA() {
    #expect(
      emptyGraph.contains(vertexWith: { vertexInGraph in
        vertexInGraph.label.starts(with: "a")
      }) == false
    )
  }
}
