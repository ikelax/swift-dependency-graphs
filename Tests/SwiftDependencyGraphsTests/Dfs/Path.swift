import Nimble
import Quick

@testable import DependencyGraphs

class DfsPathTests: QuickSpec {
  override class func spec() {
    describe("starting from vertex 1 in forwards direction") {
      describe("visits all vertices") {
        it("with the public method") {
          expect(
            TestGraph.path().depthFirstSearch(
              startingFrom: vertex1, in: .forwards, reduceWith: appendReducer, withInitialValue: []
            )
          )
          .to(equal([vertex1, vertex2, vertex3, vertex4, vertex5]))
        }

        it("with the private method") {
          expect(
            TestGraph.path().depthFirstSearchImpl(
              startingFrom: vertex1, in: .forwards, withVisited: [], reduceWith: appendReducer,
              withInitialValue: [])
          )
          .to(equal([vertex1, vertex2, vertex3, vertex4, vertex5]))
        }
      }

      it("stops at 2 because 3 was already discovered") {
        expect(
          TestGraph.path().depthFirstSearchImpl(
            startingFrom: vertex1, in: .forwards, withVisited: [vertex3],
            reduceWith: appendReducer, withInitialValue: [])
        )
        .to(equal([vertex1, vertex2]))
      }

      it("visits no vertices because all were already discovered") {
        expect(
          TestGraph.path().depthFirstSearchImpl(
            startingFrom: vertex1, in: .forwards,
            withVisited: [vertex1, vertex2, vertex3, vertex4, vertex5],
            reduceWith: appendReducer, withInitialValue: emptyVertexList)
        )
        .to(equal([]))
      }

      it("visits no vertices because 1 was already discovered") {
        expect(
          TestGraph.path().depthFirstSearchImpl(
            startingFrom: vertex1, in: .forwards, withVisited: [vertex1],
            reduceWith: appendReducer, withInitialValue: emptyVertexList)
        )
        .to(equal([]))
      }
    }
  }
}
