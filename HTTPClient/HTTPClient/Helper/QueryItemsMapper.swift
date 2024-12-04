import Foundation

public struct QueryItemsMapper {
    static func map(key: String, value: Any) -> URLQueryItem {
        URLQueryItem(name: key, value: String(describing: value))
    }
}
