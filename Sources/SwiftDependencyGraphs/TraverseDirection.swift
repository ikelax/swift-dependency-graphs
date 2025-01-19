/// The direction in which depth-first search traverses. For `forwards` direction the `outgoing_edges`
/// of the graph are used and depth-first search traverses in direction of the arrows. For `backwards` direction
/// the `incoming_edges` are used and depth-first search traverses in opposite direction of the arrows.
public enum TraverseDirection {
  case backwards
  case forwards
}
