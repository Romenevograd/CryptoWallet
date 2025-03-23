import Foundation

final class AppStorages: IStorages {
    let appDefaults: any IAppDefaults

    init(appDefaults: any IAppDefaults) {
        self.appDefaults = appDefaults
    }
}
