import DependencyGraphs

// A -> B means that A depends on B
typealias PackageGraph = DependencyGraph<Package>

extension PackageGraph {
  func findAllDependencies(of package: Package) -> [Package] {
    // Traverse the graph starting from package
    // and collect vertices visited
    []
  }

  // This should be in `DependencyGraph`.
  func insert(package: Package, withDependencies dependencies: [Package]) {
    // Call `insert` method in `DependencyGraph`.
    // `insert` also inserts the dependencies and checks
    // if circular dependencies would be introduced.
  }

  func findDependents(of package: Package) -> [Package] {
    // Traverse graph in reverse direction
    // and collect packages.
    []
  }
}
