import Foundation

protocol ICryptoCurrenciesRepository {
    var apiService: API { get }

    func fetchCurrency(_ endpoint: APIEndpoint) async throws -> CryptoCurrency
}

final class CryptoCurrenciesRepository: ICryptoCurrenciesRepository {
    let apiService: any API

    init(apiService: any API) {
        self.apiService = apiService
    }

    func fetchCurrency(_ endpoint: APIEndpoint) async throws -> CryptoCurrency {
        try await apiService.send(from: endpoint)
    }
}
