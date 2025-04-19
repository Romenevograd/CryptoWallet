import Foundation

struct CurrencyItem: Codable, Equatable {
    var name: String
    let symbol: String
    let price: Double
    let change24h: Double?
}

struct MessariResponse: Codable {
    let data: MetricsData
}

struct MetricsData: Codable {
    let marketData: MarketData
    
    enum CodingKeys: String, CodingKey {
        case marketData = "market_data"
    }
}

struct MarketData: Codable {
    let priceUsd: Double
    let percentChangeUsdLast24Hours: Double
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
    }
}
