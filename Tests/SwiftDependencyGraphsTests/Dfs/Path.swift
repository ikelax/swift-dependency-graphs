import Quick
import Nimble
@testable import DependencyGraphs

class DfsPathTests: QuickSpec {
    override class func spec() {
        describe("starting from vertex 1 in forwards direction") {
            describe("visits all vertices") {
                it("with the public method") {
                    expect(TestGraph.path().depthFirstSearch(startingFrom: vertex_1, in: .forwards, reduceWith: appendReducer, withInitialValue: []))
                        .to(equal([vertex_1, vertex_2, vertex_3, vertex_4, vertex_5]))
                }
                
                it("with the private method") {
                    expect(TestGraph.path().depthFirstSearchImpl(startingFrom: vertex_1, in: .forwards, withVisited: [], reduceWith: appendReducer, withInitialValue: []))
                        .to(equal([vertex_1, vertex_2, vertex_3, vertex_4]))
                }
            }
            
            it("stops at 2 because 3 was already discovered") {
                expect(TestGraph.path().depthFirstSearchImpl(startingFrom: vertex_1, in: .forwards, withVisited: Set(arrayLiteral: vertex_3), reduceWith: appendReducer, withInitialValue: []))
                    .to(equal([vertex_1, vertex_2]))
            }
            
            it("visits no vertices because all were already discovered") {
                expect(TestGraph.path().depthFirstSearchImpl(startingFrom: vertex_1, in: .forwards, withVisited: Set(arrayLiteral: vertex_1, vertex_2, vertex_3, vertex_4, vertex_5), reduceWith: appendReducer, withInitialValue: emptyVertexList))
                    .to(equal([]))
            }
            
            it("visits no vertices because 1 was already discovered") {
                expect(TestGraph.path().depthFirstSearchImpl(startingFrom: vertex_1, in: .forwards, withVisited: Set(arrayLiteral: vertex_1), reduceWith: appendReducer, withInitialValue: emptyVertexList))
                    .to(equal([]))
            }
        }
    }
}

