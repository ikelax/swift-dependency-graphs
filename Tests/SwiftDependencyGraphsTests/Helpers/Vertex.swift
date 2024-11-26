/**
 In comments or descriptions, a vertex with `id` `n` is referred to as `v${n}`.
 Just using the `id` or the `label` may be confusing.
 */
struct Vertex: Identifiable, Hashable {
    let id: Int
    /// `label` is used for testing how the library handles properties.
    let label: String
}

let vertex_1 = Vertex(id: 1)
let vertex_2 = Vertex(id: 2)
let vertex_3 = Vertex(id: 3)
let vertex_4 = Vertex(id: 4)
let vertex_5 = Vertex(id: 5)
let vertex_6 = Vertex(id: 6)
let vertex_7 = Vertex(id: 7)

let emptyVertexList: [Vertex] = []

extension Vertex {
    /// Convenience to also use `id` to set `label`.
    init(id: Int) {
        self.init(id: id, label: "\(id)")
    }
}
