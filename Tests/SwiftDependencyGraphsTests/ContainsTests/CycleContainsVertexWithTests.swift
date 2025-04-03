import Testing

@testable import DependencyGraphs

@Suite("Cycle with vertices v1 to v4") struct CycleContainsVertexWithTests {
  let cycle = TestGraph.cycle()

  @Test("contains a vertex with an odd id") func oddId() {
    #expect(
      cycle.contains(vertexWith: { vertexInGraph in
        !vertexInGraph.id.isMultiple(of: 2)
      }) == true
    )
  }

  @Test("does not contain a vertex with an id that is divisible by 5") func notDivisibleBy5() {
    #expect(
      cycle.contains(vertexWith: { vertexInGraph in
        vertexInGraph.id.isMultiple(of: 5)
      }) == false
    )
  }

  @Test("contains a vertex with a label that starts with 3") func labelStartsWith3() {
    #expect(
      cycle.contains(vertexWith: { vertexInGraph in
        vertexInGraph.label.starts(with: "3")
      }) == true
    )
  }

  @Test("does not contain a vertex with a label that ends with .") func labelEndsWithDot() {
    #expect(
      cycle.contains(vertexWith: { vertexInGraph in
        vertexInGraph.label.hasSuffix(".")
      }) == false
    )
  }
}
