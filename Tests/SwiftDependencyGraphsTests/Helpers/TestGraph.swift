@testable import DependencyGraphs

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
        c4.incomingEdges = [
            vertex_1.id: [vertex_4],
            vertex_2.id: [vertex_1],
            vertex_3.id: [vertex_2],
            vertex_4.id: [vertex_3],
        ]
        c4.outgoingEdges = [
            vertex_1.id: [vertex_2],
            vertex_2.id: [vertex_3],
            vertex_3.id: [vertex_4],
            vertex_4.id: [vertex_1],
        ]

        return c4
    }
    
    /// Returns the graph P5 that looks like this: 1 --> 2 --> 3 --> 4 --> 5. Such a graph is called a path (on 5 vertices).
    static func path() -> TestGraph {
        var p5 = TestGraph()
        p5.vertices = [
            vertex_1.id: vertex_1,
            vertex_2.id: vertex_2,
            vertex_3.id: vertex_3,
            vertex_4.id: vertex_4,
            vertex_5.id: vertex_5,
        ]
        p5.incomingEdges = [
            vertex_1.id: [],
            vertex_2.id: [vertex_1],
            vertex_3.id: [vertex_2],
            vertex_4.id: [vertex_3],
            vertex_5.id: [vertex_4],
        ]
        p5.outgoingEdges = [
            vertex_1.id: [vertex_2],
            vertex_2.id: [vertex_3],
            vertex_3.id: [vertex_4],
            vertex_4.id: [vertex_5],
            vertex_5.id: [],
        ]
        
        return p5
    }
    
    /**
     Returns the graph which looks like this: 1 --> 2 <-- 3 --> 4 .
     */
    static func path4WithInvertedEdge() -> TestGraph {
        var p4WithInvertedEdge = TestGraph()
        p4WithInvertedEdge.vertices = [
            vertex_1.id: vertex_1,
            vertex_2.id: vertex_2,
            vertex_3.id: vertex_3,
            vertex_4.id: vertex_4,
        ]
        p4WithInvertedEdge.incomingEdges = [
            vertex_1.id: [],
            vertex_2.id: [vertex_1, vertex_3],
            vertex_3.id: [],
            vertex_4.id: [vertex_3],
        ]
        p4WithInvertedEdge.outgoingEdges = [
            vertex_1.id: [vertex_2],
            vertex_2.id: [],
            vertex_3.id: [vertex_2, vertex_4],
            vertex_4.id: [],
        ]
        
        return p4WithInvertedEdge
    }
    
    /**
     Returns the sketched binary tree.
     
     The edges are directed from top to bottom.
     ```
         1
        / \
       2   3
      / \ / \
     4  5 6  7
     ```
     */
    static func binaryTree() -> TestGraph {
        var binaryTree = TestGraph()
        
        binaryTree.vertices = [
            vertex_1.id: vertex_1,
            vertex_2.id: vertex_2,
            vertex_3.id: vertex_3,
            vertex_4.id: vertex_4,
            vertex_5.id: vertex_5,
            vertex_6.id: vertex_6,
            vertex_7.id: vertex_7,
        ]
        
        binaryTree.incomingEdges = [
            vertex_1.id: [],
            vertex_2.id: [vertex_1],
            vertex_3.id: [vertex_1],
            vertex_4.id: [vertex_2],
            vertex_5.id: [vertex_2],
            vertex_6.id: [vertex_3],
            vertex_7.id: [vertex_3],
        ]
        
        binaryTree.outgoingEdges = [
            vertex_1.id: [vertex_2, vertex_3],
            vertex_2.id: [vertex_4, vertex_5],
            vertex_3.id: [vertex_6, vertex_7],
            vertex_4.id: [],
            vertex_5.id: [],
            vertex_6.id: [],
        ]
        
        return binaryTree
    }
    
    /**
     Returns a graph with two disconnected components.
     
     The graph looks like this. There is no path from the subgraph 1 --> 2
     to the rest of the graph.
     
     1 --> 2
     
     3 --> 4 --> 5

     3 --> 5
     
     4 --> 6
     */
    static func twoDisconnectedComponents() -> TestGraph {
        var twoDisconnectedComponents = TestGraph()
        twoDisconnectedComponents.vertices = [
            vertex_1.id: vertex_1,
            vertex_2.id: vertex_2,
            vertex_3.id: vertex_3,
            vertex_4.id: vertex_4,
            vertex_5.id: vertex_5,
            vertex_6.id: vertex_6,
        ]
        
        twoDisconnectedComponents.incomingEdges = [
            vertex_1.id: [],
            vertex_2.id: [vertex_1],
            vertex_3.id: [],
            vertex_4.id: [vertex_3],
            vertex_5.id: [vertex_3, vertex_4],
            vertex_6.id: [vertex_4],
        ]
        
        twoDisconnectedComponents.outgoingEdges = [
            vertex_1.id: [vertex_2],
            vertex_2.id: [],
            vertex_3.id: [vertex_4, vertex_5],
            vertex_4.id: [vertex_5, vertex_6],
            vertex_5.id: [],
            vertex_6.id: [],
        ]
        
        return twoDisconnectedComponents
    }
    
    /**
     Returns the graph on 3 vertices without any edges.
     */
    static func complementOfK3() -> TestGraph {
        var complementOfK3 = TestGraph()
        complementOfK3.vertices = [
            vertex_1.id: vertex_1,
            vertex_2.id: vertex_2,
            vertex_3.id: vertex_3,
        ]
        
        return complementOfK3
    }
}
