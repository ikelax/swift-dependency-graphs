import Testing

@Suite("Neighbour lookup") struct NeighboursTests {
  @Suite("If the vertex is not in the graph") struct VertexNotInGraphTests {
    let graph = TestGraph.complementOfK3()
    let vertexNotInGraph = Vertex(id: -1)

    @Test("returns nil for forwards direction") func forwards() {
      #expect(graph.neighbours(of: vertexNotInGraph, in: .forwards) == nil)
    }

    @Test("returns nil for backwards direction") func backwards() {
      #expect(graph.neighbours(of: vertexNotInGraph, in: .backwards) == nil)
    }

    @Test("returns nil for both directions") func both() {
      #expect(graph.neighbours(of: vertexNotInGraph) == nil)
    }
  }

  @Suite("If the vertex is in the graph") struct VertexInGraphTests {
    let graph = TestGraph.binaryTree()

    @Test("returns its neighbours for forwards direction") func forwards() {
      #expect(graph.neighbours(of: vertex2, in: .forwards) == [vertex4, vertex5])
    }

    @Test("returns its neighbours for backwards direction") func backwards() {
      #expect(graph.neighbours(of: vertex2, in: .backwards) == [vertex1])
    }

    @Test("returns its neighbours for both directions") func both() {
      #expect(
        graph.neighbours(of: vertex3).unsafelyUnwrapped.isEqualSet(to: [vertex1, vertex6, vertex7]))
    }
  }

  @Suite("If the vertex has no neighbours") struct VertexHasNoNeighboursTests {

    @Suite("in forwards direction") struct NoNeighboursInForwardsDirectionTests {
      let graph = TestGraph.binaryTree()

      @Test("returns an empty set for forwards direction") func forwards() {
        #expect(graph.neighbours(of: vertex6, in: .forwards) == [])
      }

      @Test("returns the neighbours for backwards direction") func backwards() {
        #expect(graph.neighbours(of: vertex6, in: .backwards) == [vertex3])
      }

      @Test("returns the neighbours in backwards direction for both directions") func both() {
        #expect(graph.neighbours(of: vertex6) == [vertex3])
      }
    }

    @Suite("in backwards direction") struct NoNeighboursInBackwardsDirectionTests {
      let graph = TestGraph.binaryTree()

      @Test("returns the neighbours for forwards direction") func forwards() {
        #expect(graph.neighbours(of: vertex1, in: .forwards) == [vertex2, vertex3])
      }

      @Test("returns an empty set for backwards direction") func backwards() {
        #expect(graph.neighbours(of: vertex1, in: .backwards) == [])
      }

      @Test("returns the neighbours in forwards direction for both directions") func both() {
        #expect(graph.neighbours(of: vertex1) == [vertex2, vertex3])
      }
    }

    @Suite("in both directions") struct NoNeighboursInBothDirectionsTests {
      let graph = TestGraph.complementOfK3()

      @Test("returns an empty set for forwards direction") func forwards() {
        #expect(graph.neighbours(of: vertex3, in: .forwards) == [])
      }

      @Test("returns an empty set for backwards direction") func backwards() {
        #expect(graph.neighbours(of: vertex3, in: .backwards) == [])
      }

      @Test("returns an empty set for both directions") func both() {
        #expect(graph.neighbours(of: vertex3) == [])
      }
    }
  }
}
