import Quick
import Nimble
@testable import swift_dependency_graphs

class DfsPathTests: QuickSpec {
    override class func spec() {

        // TODO: appendReducer
        
        describe("starting from vertex 1 in forwards direction") {
            it("visits all vertices") {
                expect(TestGraph.path5().depthFirstSearch(startingFrom: vertex_1, in: .forwards, withVisited: Set(), reduceWith: appendReducer, withInitialValue: []))
                    .to(equal([vertex_1, vertex_2, vertex_3, vertex_4, vertex_5]))
            }
            
            it("stops at 2 because 3 was already discovered") {
                expect(TestGraph.path5().depthFirstSearch(startingFrom: vertex_1, in: .forwards, withVisited: Set(arrayLiteral: vertex_3), reduceWith: appendReducer, withInitialValue: []))
                    .to(equal([vertex_1, vertex_2]))
            }
            
            it("visits no vertices because all were already discovered") {
                expect(TestGraph.path5().depthFirstSearch(startingFrom: vertex_1, in: .forwards, withVisited: Set(arrayLiteral: vertex_1, vertex_2, vertex_3, vertex_4, vertex_5), reduceWith: appendReducer, withInitialValue: emptyVertexList))
                    .to(equal([]))
            }
            
            it("visits no vertices because 1 was already discovered") {
                expect(TestGraph.path5().depthFirstSearch(startingFrom: vertex_1, in: .forwards, withVisited: Set(arrayLiteral: vertex_1), reduceWith: appendReducer, withInitialValue: emptyVertexList))
                    .to(equal([]))
            }
        }
    }
}

