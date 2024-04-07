import SwiftUI
import Observation

public class AnyIdentifiable: Identifiable {
    public let destination: any Identifiable

    public init(destination: any Identifiable) {
        self.destination = destination
    }
}

@Observable
public final class Router {
     public var navPath = NavigationPath()
     public var presentedSheet: AnyIdentifiable?

    public init() {}

    public func presentSheet(destination: any Identifiable) {
        presentedSheet = AnyIdentifiable(destination: destination)
    }

    public func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }

    public func navigateBack() {
        navPath.removeLast()
    }

    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
