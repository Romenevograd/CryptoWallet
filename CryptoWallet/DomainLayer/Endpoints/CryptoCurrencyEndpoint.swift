import Foundation

struct CryptoCurrencyEndpoint: APIEndpoint {
    let path: String
    let method: APIMethod = .get

    init(_ symbol: String) {
        self.path = "/assets\(symbol)/metrics"
    }
}
