import Foundation

public class DependencyResolver {
    private var dependencies = [String: AnyObject]()

    public func register<T>(dependency: T, for key: String) {
        dependencies[key] = dependency as AnyObject
    }

    public func resolve<T>(key: String) -> T? {
        return dependencies[key] as? T
    }
}
