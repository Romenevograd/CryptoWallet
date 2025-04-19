import Foundation

final class CurrencyManager {
    private let service: CurrencyServiceProtocol
    private let symbols = ["BTC", "ETH", "TRX", "LUNA", "CELL", "DOGE", "USDT", "XLM", "ADA", "XRP"]
    
    init(service: CurrencyServiceProtocol = CurrencyService()) {
        self.service = service
    }
    
    func fetchAllCurrencies(completion: @escaping (Result<[CurrencyItem], Error>) -> Void) {
        var results: [CurrencyItem] = []
        var errors: [Error] = []

        let dispatchGroup = DispatchGroup()

        for symbol in symbols {
            dispatchGroup.enter()
            
            service.fetchCurrencyData(for: symbol) { result in
                switch result {
                case var .success(item):
                    if let name = self.getNameForSymbol(symbol) {
                        item.name = name
                    }
                    results.append(item)
                case let .failure(error):
                    errors.append(error)
                }

                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = errors.first {
                completion(.failure(error))
            } else {
                completion(.success(results))
            }
        }
    }
    
    private func getNameForSymbol(_ symbol: String) -> String? {
        let symbolToName = [
            "BTC": "Bitcoin",
            "ETH": "Ethereum",
            "TRX": "Tron",
            "LUNA": "Terra",
            "CELL": "Cellframe",
            "DOGE": "Dogecoin",
            "USDT": "Tether",
            "XLM": "Stellar",
            "ADA": "Cardano",
            "XRP": "Ripple"
        ]
        return symbolToName[symbol]
    }
}
