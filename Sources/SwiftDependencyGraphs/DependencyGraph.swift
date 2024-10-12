import OrderedCollections

public struct DependencyGraph<V> where V: Hashable, V: Identifiable {
    typealias Edge = (V, V)
    
    /// The vertices of the dependency graph.
    public internal(set) var vertices: [V.ID: V] = [:]
    
    // For efficiency, two hashsets are maintained.
    /**
     Incoming edges of a vertex are directed edges that the vertex is the destination.
     
     The edge `v --> w` (or `(v, w)`) is an incoming edge of `w`, but not of `v`.
     In this case, `w` is a key and `v` its value.
     
     - Note: Informally speaking, `v` is adjacent to `w`, or a neighbour of `w`, and
     `w` is targeted by `v`'s arrow.
     */
    public internal(set) var incoming_edges: [V.ID: OrderedSet<V>] = [:]
    
    /**
     Outgoing edges of a vertex are directed edges that the vertex is the origin.
     
     The edge `v --> w` (or `(v, w)`) is an outgoing edge of `v`, but not of `w`.
     In this case, `v` is a key and `w` its value.
     
     - Note: Informally speaking, `v` is adjacent to `w`, or a neighbour of `w`, and
     its arrow points to `w`.
     */
    public internal(set) var outgoing_edges: [V.ID: OrderedSet<V>] = [:]
    
    func contains(vertex: V) -> Bool {
        return contains(vertexWith: {v in v.id == vertex.id})
    }
    
    /**
     Returns `true` iff at least one vertex satifies the `predicate`.
     */
    func contains(vertexWith predicate: (V) -> Bool) -> Bool {
        return vertices.contains(where: {_, vertex in predicate(vertex)})
    }
}
