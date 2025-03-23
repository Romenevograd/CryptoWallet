import Foundation

enum AppKey: CaseIterable {
    case loggedIn

    var value: String {
        switch self {
        case .loggedIn: "isLoggedInKey"
        }
    }
}

protocol IAppDefaults {
    func set(value: Bool, for key: AppKey)
    func get(for key: AppKey) -> Bool
}

final class AppDefaultsManager: IAppDefaults {
    let defaults: IDefaults

    init(defaults: IDefaults) {
        self.defaults = defaults
    }

    func set(value: Bool, for key: AppKey) {
        defaults.save(value: value, forKey: key.value)
    }

    func get(for key: AppKey) -> Bool {
        defaults.get(forKey: key.value) ?? false
    }
}
