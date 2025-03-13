import OrderedCollections

public enum RemoveVertexError<V: Sendable & Hashable>: Error {
  case notInGraph(_ vertex: V)

  case hasEdgesTo(incoming: OrderedSet<V>, outgoing: OrderedSet<V>)
}
