import Foundation

public protocol API {
    func send<T: Decodable>(from endpoint: APIEndpoint) async throws -> T
}
