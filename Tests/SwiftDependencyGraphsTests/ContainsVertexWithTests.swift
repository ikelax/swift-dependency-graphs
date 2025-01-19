import Nimble
import Quick

@testable import DependencyGraphs

class ContainsVertexWithTests: QuickSpec {
  override class func spec() {

    // C4 has only vertices with the ids 1, 2, 3 and 4.
    // swift-format-ignore: AlwaysUseLowerCamelCase
    let vertex_1_prime_with_same_label = Vertex(id: 5, label: "1")
    // swift-format-ignore: AlwaysUseLowerCamelCase
    let vertex_1_prime_with_same_id = Vertex(id: vertex_1.id, label: "not 1")

    describe("C4 with vertices v1, v2, v3 and v4") {
      it("contains the vertex v1") {
        expect(TestGraph.directedC4().contains(vertex: vertex_1)).to(beTrue())
      }

      it("does not contain the vertex v5") {
        expect(TestGraph.directedC4().contains(vertex: vertex_5)).to(beFalse())
      }

      it("contains the vertex v1' with v1' ≠ v1 and v1'.id = v1.id") {
        expect(TestGraph.directedC4().contains(vertex: vertex_1_prime_with_same_id)).to(beTrue())
      }

      it("does not contain the vertex v1' with v1' ≠ v1 and v1'.label = v1.label") {
        expect(TestGraph.directedC4().contains(vertex: vertex_1_prime_with_same_label)).to(
          beFalse())
      }

      it("contains a vertex with an odd id") {
        expect(TestGraph.directedC4().contains(vertexWith: { v in !v.id.isMultiple(of: 2) })).to(
          beTrue())
      }

      it("does not contain a vertex with an id that is divisible by 5") {
        expect(TestGraph.directedC4().contains(vertexWith: { v in v.id.isMultiple(of: 5) })).to(
          beFalse())
      }

      it("contains a vertex with a label that starts with 3") {
        expect(TestGraph.directedC4().contains(vertexWith: { v in v.label.starts(with: "3") })).to(
          beTrue())
      }

      it("does not contain a vertex with a label that ends with .") {
        expect(TestGraph.directedC4().contains(vertexWith: { v in v.label.hasSuffix(".") })).to(
          beFalse())
      }
    }

    describe("the empty graph") {
      it("does not contain the vertex v") {
        expect(TestGraph.empty.contains(vertex: vertex_1)).to(beFalse())
      }

      it("does not contain a vertex with an even id") {
        expect(TestGraph.empty.contains(vertexWith: { v in v.id.isMultiple(of: 2) })).to(beFalse())
      }

      it("does not contain a vertex with a label that starts with a") {
        expect(TestGraph.empty.contains(vertexWith: { v in v.label.starts(with: "a") })).to(
          beFalse())
      }
    }
  }
}
