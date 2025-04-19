import Foundation

protocol CurrencyServiceProtocol {
    func fetchCurrencyData(for symbol: String, completion: @escaping (Result<CurrencyItem, Error>) -> Void)
}

final class CurrencyService: CurrencyServiceProtocol {
    private let baseUrl = "https://data.messari.io/api/v1/assets"
    
    func fetchCurrencyData(
        for symbol: String,
        completion: @escaping (Result<CurrencyItem, Error>) -> Void
    ) {
        let urlString = "\(baseUrl)/\(symbol)/metrics"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(MessariResponse.self, from: data)

                let currencyItem = CurrencyItem(
                    name: "",
                    symbol: symbol,
                    price: model.data.marketData.priceUsd,
                    change24h: model.data.marketData.percentChangeUsdLast24Hours
                )
                
                completion(.success(currencyItem))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
}
