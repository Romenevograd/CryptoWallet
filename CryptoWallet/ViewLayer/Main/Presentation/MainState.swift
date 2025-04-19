import Foundation

enum MainState: Equatable {
    case result(items: [CurrencyItem])
    case loading
    case error(String)
}
