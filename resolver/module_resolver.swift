import Foundation

public class ModuleResolver {
    private var modules = [String: AnyObject]()

    public func registerModule<T>(module: T, for key: String) {
        modules[key] = module as AnyObject
    }

    public func resolveModule<T>(key: String) -> T? {
        return modules[key] as? T
    }
}
