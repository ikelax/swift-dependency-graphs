@testable import swift_dependency_graphs

typealias TestGraph = DependencyGraph<Vertex>

extension TestGraph {
    /**
     Returns an empty graph.
     */
    static var empty: TestGraph { DependencyGraph() }
    
    /**
     The graph C4 looks like this: 1 --> 2 --> 3 --> 4 --> 1.
     
     - Returns: The graph C4.
     - Note: The directed cyclic graph on 4 vertices is usually denoted by $C^4$ or $C\_4$.
     */
    static func directedC4() -> TestGraph {
        var c4 = TestGraph()
        c4.vertices = [
            vertex_1.id: vertex_1,
            vertex_2.id: vertex_2,
            vertex_3.id: vertex_3,
            vertex_4.id: vertex_4,
        ]
        c4.incoming_edges = [
            vertex_1.id: [vertex_4],
            vertex_2.id: [vertex_1],
            vertex_3.id: [vertex_2],
            vertex_4.id: [vertex_3],
        ]
        c4.outgoing_edges = [
            vertex_1.id: [vertex_2],
            vertex_2.id: [vertex_3],
            vertex_3.id: [vertex_4],
            vertex_4.id: [vertex_1],
        ]
            
        return c4
    }
}
