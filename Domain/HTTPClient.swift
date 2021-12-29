import Foundation
import Combine
import Moya

public protocol HTTPClient {
    func send<Response: Codable>(_ service: MyService) async throws -> Response
    func send(_ service: MyService) async throws
}

public struct HTTPClientImpl {
    private let provider = MoyaProvider<MyService>()
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    public init() { }
}

extension HTTPClientImpl: HTTPClient {
    public func send(_ service: MyService) async throws {
        let _: Void = try await withCheckedThrowingContinuation { continuation in
            provider.request(service) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)

                case .success:
                    continuation.resume(returning: ())
                }
            }
        }
    }

    public func send<Response>(_ service: MyService) async throws -> Response where Response : Decodable, Response : Encodable {
        let response: Response = try await withCheckedThrowingContinuation { continuation in
            provider.request(service) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)

                case .success(let response):
                    let data = response.data
                    do {
                        let model = try decoder.decode(Response.self, from: data)
                        continuation.resume(returning: model)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
        return response
    }
}
