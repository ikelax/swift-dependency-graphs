import OrderedCollections

public struct RemoveVertexSuccess<V: Hashable>: Equatable {

  struct RemovedEdges: Equatable {
    let edges: OrderedSet<V>
  }

  /// The removed vertex.
  let vertex: V
  /// The outgoing edges that have been removed with the vertex. The set is only non-empty
  /// if the vertex was removed by force.
  let outgoingEdges: RemovedEdges
  /// The incoming edges that have been removed with the vertex. The set is only non-empty
  /// if the vertex was removed by force.
  let incomingEdges: RemovedEdges

  init(vertex: V, outgoingEdges: OrderedSet<V>, incomingEdges: OrderedSet<V>) {
    self.vertex = vertex
    self.outgoingEdges = RemovedEdges(edges: outgoingEdges)
    self.incomingEdges = RemovedEdges(edges: incomingEdges)
  }
}
