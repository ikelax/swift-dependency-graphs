import Nimble
import Quick

@testable import DependencyGraphs

class ContainsVertexWithTests: QuickSpec {
  // swiftlint:disable:next function_body_length
  override class func spec() {

    // C4 has only vertices with the ids 1, 2, 3 and 4.
    let vertexWithLabel1 = Vertex(id: 5, label: "1")
    let vertexWithId1 = Vertex(id: vertex1.id, label: "not 1")

    describe("C4 with vertices v1, v2, v3 and v4") {
      it("contains the vertex v1") {
        expect(TestGraph.directedC4().contains(vertex: vertex1)).to(beTrue())
      }

      it("does not contain the vertex v5") {
        expect(TestGraph.directedC4().contains(vertex: vertex5)).to(beFalse())
      }

      it("contains the vertex v1' with v1' ≠ v1 and v1'.id = v1.id") {
        expect(TestGraph.directedC4().contains(vertex: vertexWithId1)).to(beTrue())
      }

      it("does not contain the vertex v1' with v1' ≠ v1 and v1'.label = v1.label") {
        expect(TestGraph.directedC4().contains(vertex: vertexWithLabel1)).to(
          beFalse())
      }

      it("contains a vertex with an odd id") {
        expect(
          TestGraph.directedC4().contains(vertexWith: { vertexInGraph in
            !vertexInGraph.id.isMultiple(of: 2)
          })
        ).to(
          beTrue())
      }

      it("does not contain a vertex with an id that is divisible by 5") {
        expect(
          TestGraph.directedC4().contains(vertexWith: { vertexInGraph in
            vertexInGraph.id.isMultiple(of: 5)
          })
        ).to(
          beFalse())
      }

      it("contains a vertex with a label that starts with 3") {
        expect(
          TestGraph.directedC4().contains(vertexWith: { vertexInGraph in
            vertexInGraph.label.starts(with: "3")
          })
        ).to(
          beTrue())
      }

      it("does not contain a vertex with a label that ends with .") {
        expect(
          TestGraph.directedC4().contains(vertexWith: { vertexInGraph in
            vertexInGraph.label.hasSuffix(".")
          })
        ).to(
          beFalse())
      }
    }

    describe("the empty graph") {
      it("does not contain the vertex v") {
        expect(TestGraph.empty.contains(vertex: vertex1)).to(beFalse())
      }

      it("does not contain a vertex with an even id") {
        expect(
          TestGraph.empty.contains(vertexWith: { vertexInGraph in vertexInGraph.id.isMultiple(of: 2)
          })
        ).to(beFalse())
      }

      it("does not contain a vertex with a label that starts with a") {
        expect(
          TestGraph.empty.contains(vertexWith: { vertexInGraph in
            vertexInGraph.label.starts(with: "a")
          })
        ).to(
          beFalse())
      }
    }
  }
}
