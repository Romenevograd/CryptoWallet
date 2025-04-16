struct CurrencyItem {
    let name: String
    let symbol: String
    
    var iconName: String {
        symbol.lowercased()
    }
}
