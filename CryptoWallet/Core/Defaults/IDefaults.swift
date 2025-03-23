import Foundation

public protocol IDefaults {
    func save<T>(value: T, forKey key: String)
    func get<T>(forKey key: String) -> T?
    func delete(forKey key: String)
}
