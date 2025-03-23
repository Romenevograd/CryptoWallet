import Foundation

public enum APIError: Error {
    case invalidURL
    case badResponse(statusCode: Int)
    case decodingError
    case unknown(Error)
}
