import OrderedCollections

public struct RemoveVertexSuccess<V: Hashable>: Equatable {
  typealias RemovedEdges = OrderedSet<V>

  /// The removed vertex.
  let vertex: V
  /// The outgoing edges that have been removed with the vertex. The set is only non-empty
  /// if the vertex was removed by force.
  let outgoingEdges: RemovedEdges
  /// The incoming edges that have been removed with the vertex. The set is only non-empty
  /// if the vertex was removed by force.
  let incomingEdges: RemovedEdges
}
