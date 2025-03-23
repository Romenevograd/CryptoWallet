import Foundation

enum AuthState: Equatable {
    case result(AuthModel)
    case loading
    case error(String)
}
