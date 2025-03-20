import OrderedCollections

public struct RemoveVertexSuccess<V: Hashable>: Equatable {
  let vertex: V
  let outgoingEdges: OrderedSet<V>
  let incomingEdges: OrderedSet<V>
}
