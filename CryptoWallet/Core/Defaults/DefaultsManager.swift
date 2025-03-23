import Foundation

public final class DefaultsManager: IDefaults {
    public let storage: UserDefaults

    public init(storage: UserDefaults = .standard) {
        self.storage = storage
    }

    public func save<T>(value: T, forKey key: String) {
        storage.setValue(value, forKey: key)
    }

    public func get<T>(forKey key: String) -> T? {
        storage.value(forKey: key) as? T
    }

    public func delete(forKey key: String) {
        storage.removeObject(forKey: key)
    }
}
