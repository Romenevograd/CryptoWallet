import Foundation

protocol IDependencies {
    var storages: IStorages { get }
    var repositories: IRepositories { get }
}

protocol IStorages {
    var appDefaults: IAppDefaults { get }
}

protocol IRepositories {
    var currencies: ICryptoCurrenciesRepository { get }
}
