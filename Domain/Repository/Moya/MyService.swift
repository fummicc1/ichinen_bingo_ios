import Foundation
import Moya

public enum MyService {
    case createBingo(title: String, todos: [Bingo.Todo])
}

extension MyService: TargetType {
    public var baseURL: URL {
        URL(string: "")!
    }

    public var path: String {
        switch self {
        case .createBingo:
            return "/bingos/new"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .createBingo:
            return .post
        }
    }

    public var task: Task {
        switch self {
        case let .createBingo(title, todos):
            return .requestParameters(
                parameters: [
                    "title": title,
                    "todos": todos
                ],
                encoding: JSONEncoding.default
            )
        }
    }

    public var headers: [String : String]? {
        [
            "Content-type": "application.json"
        ]
    }
}
