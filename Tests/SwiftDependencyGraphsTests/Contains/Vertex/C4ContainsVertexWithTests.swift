import Testing

import DependencyGraphs

@Suite("C4 with vertices v1, v2, v3 and v4") struct C4ContainsVertexWithTests {
  @Test("contains a vertex with an odd id") func oddId() {
    #expect(
      TestGraph.directedC4().contains(vertexWith: { vertexInGraph in
        !vertexInGraph.id.isMultiple(of: 2)
      }) == true
    )
  }

  @Test("does not contain a vertex with an id that is divisible by 5") func notDivisibleBy5() {
    #expect(
      TestGraph.directedC4().contains(vertexWith: { vertexInGraph in
        vertexInGraph.id.isMultiple(of: 5)
      }) == false
    )
  }

  @Test("contains a vertex with a label that starts with 3") func labelStartsWith3() {
    #expect(
      TestGraph.directedC4().contains(vertexWith: { vertexInGraph in
        vertexInGraph.label.starts(with: "3")
      }) == true
    )
  }

  @Test("does not contain a vertex with a label that ends with .") func labelEndsWithDot() {
    #expect(
      TestGraph.directedC4().contains(vertexWith: { vertexInGraph in
        vertexInGraph.label.hasSuffix(".")
      }) == false
    )
  }
}
