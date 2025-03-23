import Foundation

public final class APIService: API {
    public let baseURL: URL
    public let session: URLSession

    init(
        baseURL: URL,
        session: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.session = session
    }

    public func send<T: Decodable>(from endpoint: APIEndpoint) async throws -> T {
        let request = try endpoint.buildRequest(baseURL)

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.badResponse(statusCode: 0)
            }

            guard httpResponse.statusCode == 200 else {
                throw APIError.badResponse(statusCode: httpResponse.statusCode)
            }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decodingError
            }
        } catch {
            throw APIError.unknown(error)
        }
    }
}
