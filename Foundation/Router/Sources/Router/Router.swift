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
    
    public var navigationPath = NavigationPath()
    public var sheetItem: Binding<AnyIdentifiable?> {
        Binding(
            get: { self.presentedSheetItem },
            set: { self.presentedSheetItem = $0 }
        )
    }
    private var presentedSheetItem: AnyIdentifiable?
    
    public init() {}
    
    public func presentSheet(destination: any Identifiable) {
        presentedSheetItem = AnyIdentifiable(destination: destination)
    }
    
    public func dismissSheet() {
        presentedSheetItem = nil
    }
    
    public func navigate(to destination: any Hashable) {
        navigationPath.append(destination)
    }
    
    public func navigateBack() {
        navigationPath.removeLast()
    }
    
    public func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
}
