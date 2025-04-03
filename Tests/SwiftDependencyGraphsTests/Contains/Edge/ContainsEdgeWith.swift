import DependencyGraphs
import Testing

@Suite("The cycle graph") struct ContainsEdgeWithTests {

  @Suite("contains an edge where") struct ContainsEdgeIdTests {
    @Test("the difference between the ids of the vertices is 1") func diff1() {
      #expect(
        TestGraph.directedC4().contains(edgeWith: { (v, w) in
          abs(v.id - w.id) == 1
        }) == true
      )
    }

    @Test("the head has an odd id") func headHasOddId() {
      #expect(
        TestGraph.directedC4().contains(edgeWith: { (v, _) in
          v.id.isMultiple(of: 2) == false
        }) == true
      )
    }

    @Test("the tail has the label '4'") func tailHasId4() {
      #expect(
        TestGraph.directedC4().contains(edgeWith: { (_, w) in
          w.label == "4"
        }) == true
      )
    }
  }

  @Suite("does not contain an edge where") struct NotContainEdgeIdTests {
    @Test("the concatenation of the labels of the vertices has length 3") func notLength3() {
      #expect(
        TestGraph.directedC4().contains(edgeWith: { (v, w) in
          (v.label + w.label).count == 3
        }) == false
      )
    }

    @Test("the head has a label that is empty") func notEmptyLabel() {
      #expect(
        TestGraph.directedC4().contains(edgeWith: { (v, _) in
          v.label.isEmpty
        }) == false
      )
    }

    @Test("the tail has an id that is greater than 10") func tailWithIdGreaterThan10() {
      #expect(
        TestGraph.directedC4().contains(edgeWith: { (_, w) in
          w.id > 10
        }) == false
      )
    }
  }
}
