import OrderedCollections

public struct RemoveVertexSuccess<V: Hashable> {
  let vertex: V
  let outgoingEdges: OrderedSet<V>
  let incomingEdges: OrderedSet<V>
}
