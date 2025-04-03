@testable import DependencyGraphs

typealias TestGraph = DependencyGraph<Vertex>

extension TestGraph {
  /// Returns an empty graph.
  static var empty: TestGraph { DependencyGraph() }

  /// The graph C4 looks like this: 1 --> 2 --> 3 --> 4 --> 1.
  ///
  /// - Returns: The graph C4.
  /// - Note: The directed cycle graph on 4 vertices is usually denoted by $C^4$ or $C\_4$.
  static func cycle() -> TestGraph {
    var circle4 = TestGraph()
    circle4.vertices = [
      vertex1,
      vertex2,
      vertex3,
      vertex4,
    ]
    circle4.incomingEdges = [
      vertex1.id: [vertex4],
      vertex2.id: [vertex1],
      vertex3.id: [vertex2],
      vertex4.id: [vertex3],
    ]
    circle4.outgoingEdges = [
      vertex1.id: [vertex2],
      vertex2.id: [vertex3],
      vertex3.id: [vertex4],
      vertex4.id: [vertex1],
    ]

    return circle4
  }

  /// Returns the graph P5 that looks like this: 1 --> 2 --> 3 --> 4 --> 5.
  /// Such a graph is called a path (on 5 vertices).
  static func path() -> TestGraph {
    var path5 = TestGraph()
    path5.vertices = [
      vertex1,
      vertex2,
      vertex3,
      vertex4,
      vertex5,
    ]
    path5.incomingEdges = [
      vertex1.id: [],
      vertex2.id: [vertex1],
      vertex3.id: [vertex2],
      vertex4.id: [vertex3],
      vertex5.id: [vertex4],
    ]
    path5.outgoingEdges = [
      vertex1.id: [vertex2],
      vertex2.id: [vertex3],
      vertex3.id: [vertex4],
      vertex4.id: [vertex5],
      vertex5.id: [],
    ]

    return path5
  }

  /// Returns the graph which looks like this: 1 --> 2 <-- 3 --> 4 .
  static func pathWithInvertedEdge() -> TestGraph {
    var p4WithInvertedEdge = TestGraph()
    p4WithInvertedEdge.vertices = [
      vertex1,
      vertex2,
      vertex3,
      vertex4,
    ]
    p4WithInvertedEdge.incomingEdges = [
      vertex1.id: [],
      vertex2.id: [vertex1, vertex3],
      vertex3.id: [],
      vertex4.id: [vertex3],
    ]
    p4WithInvertedEdge.outgoingEdges = [
      vertex1.id: [vertex2],
      vertex2.id: [],
      vertex3.id: [vertex2, vertex4],
      vertex4.id: [],
    ]

    return p4WithInvertedEdge
  }

  /// Returns the sketched binary tree.
  ///
  /// The edges are directed from top to bottom.
  /// ```
  ///     1
  ///    / \
  ///   2   3
  ///  / \ / \
  /// 4  5 6  7
  /// ```
  static func binaryTree() -> TestGraph {
    var binaryTree = TestGraph()

    binaryTree.vertices = [
      vertex1,
      vertex2,
      vertex3,
      vertex4,
      vertex5,
      vertex6,
      vertex7,
    ]

    binaryTree.incomingEdges = [
      vertex1.id: [],
      vertex2.id: [vertex1],
      vertex3.id: [vertex1],
      vertex4.id: [vertex2],
      vertex5.id: [vertex2],
      vertex6.id: [vertex3],
      vertex7.id: [vertex3],
    ]

    binaryTree.outgoingEdges = [
      vertex1.id: [vertex2, vertex3],
      vertex2.id: [vertex4, vertex5],
      vertex3.id: [vertex6, vertex7],
      vertex4.id: [],
      vertex5.id: [],
      vertex6.id: [],
    ]

    return binaryTree
  }

  /// Returns a graph with two disconnected components.
  ///
  /// The graph looks like this. There is no path from the subgraph 1 --> 2
  /// to the rest of the graph.
  ///
  /// 1 --> 2
  ///
  /// 3 --> 4 --> 5
  ///
  /// 3 --> 5
  ///
  /// 4 --> 6
  static func twoDisconnectedComponents() -> TestGraph {
    var twoDisconnectedComponents = TestGraph()
    twoDisconnectedComponents.vertices = [
      vertex1,
      vertex2,
      vertex3,
      vertex4,
      vertex5,
      vertex6,
    ]

    twoDisconnectedComponents.incomingEdges = [
      vertex1.id: [],
      vertex2.id: [vertex1],
      vertex3.id: [],
      vertex4.id: [vertex3],
      vertex5.id: [vertex3, vertex4],
      vertex6.id: [vertex4],
    ]

    twoDisconnectedComponents.outgoingEdges = [
      vertex1.id: [vertex2],
      vertex2.id: [],
      vertex3.id: [vertex4, vertex5],
      vertex4.id: [vertex5, vertex6],
      vertex5.id: [],
      vertex6.id: [],
    ]

    return twoDisconnectedComponents
  }

  /// Returns the graph on 3 vertices without any edges.
  static func threeVertices() -> TestGraph {
    var threeVertices = TestGraph()
    threeVertices.vertices = [
      vertex1,
      vertex2,
      vertex3,
    ]

    threeVertices.incomingEdges = [
      vertex1.id: [],
      vertex2.id: [],
      vertex3.id: [],
    ]

    threeVertices.outgoingEdges = [
      vertex1.id: [],
      vertex2.id: [],
      vertex3.id: [],
    ]

    return threeVertices
  }

  static func oneVertex() -> TestGraph {
    var graph = TestGraph()

    graph.vertices = [
      vertex1.id: vertex1
    ]

    graph.incomingEdges = [
      vertex1.id: []
    ]

    graph.outgoingEdges = [
      vertex1.id: []
    ]

    return graph
  }
}
