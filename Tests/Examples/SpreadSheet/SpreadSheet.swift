import DependencyGraphs

// A -> B means that A depends on B
typealias SpreadSheet = DependencyGraph<Cell>

extension SpreadSheet {
  // This should be in `DependencyGraph`.
  func insert(cell: Cell, withDependencies dependencies: [Cell: Cell]) {
    // Call `insert` method in `DependencyGraph`.
    // `inserts` also inserts the dependencies of `cell`
    // and checks if circular dependencies would be introduced.
  }

  func update(cell: Cell, with newExpression: String) {
    compute(expression: newExpression)
    // Call `update` method in `DependencyGraph`
    // to update `expression` and `computedValue` for `cell`.
    // `update` also updates the dependencies of `cell`
    // and checks if circular dependencies would be introduced.
    // We need to recompute values of cells that depend on `cell`.
    // Traverse graph with dfs starting from `cell`
    // and update their values.
  }

  func compute(expression: String) {
    // Parse expression and get cell names C it depends on.
    // Find C in `vertices` dictionary.
    // We don't need to recompute value of C.
    // Compute expression.
  }

  // This should be in `DependencyGraph`.
  // There is no domain specific logic here.
  func remove(cell: Cell) {}
}
