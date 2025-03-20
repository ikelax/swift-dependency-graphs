import OrderedCollections

public enum RemoveVertexError<V: Sendable & Hashable>: Error, Equatable {
  case notInGraph(_ vertex: V)

  case hasEdgesTo(incoming: OrderedSet<V>, outgoing: OrderedSet<V>)
}
