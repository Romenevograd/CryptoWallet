import Foundation

final class AppRepositories: IRepositories {
    let currencies: any ICryptoCurrenciesRepository

    init(currencies: any ICryptoCurrenciesRepository) {
        self.currencies = currencies
    }
}
