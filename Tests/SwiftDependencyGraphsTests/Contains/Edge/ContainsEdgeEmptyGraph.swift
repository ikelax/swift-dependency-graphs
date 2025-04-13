import DependencyGraphs
import Testing

@Suite("The empty graph") struct ContainsEdgeEmptyGraphTests {

  @Test("does not contain the edge (v1, v2)") func notEdgeV1V2() {
    #expect(TestGraph.empty.contains(edge: (vertex1, vertex2)) == false)
  }

  @Test("does not contain an edge where the sum of the ids of its vertices is 5") func sum5() {
    #expect(
      TestGraph.empty.containsEdge(with: { (head, tail) in head.id + tail.id == 5
      }) == false
    )
  }

  @Test("does not contain an edge where the label of the head that starts with h")
  func notHeadLabelh() {
    #expect(
      TestGraph.empty.containsEdge(with: { (head, _) in
        head.label.starts(with: "h")
      }) == false
    )
  }
}
