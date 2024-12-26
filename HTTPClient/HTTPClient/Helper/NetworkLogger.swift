import Foundation

public protocol NetworkLoggerProtocol {
    func log(urlRequest: URLRequest, response: HTTPURLResponse?, dataResponse: Data?, error: Error?)
}

public struct NetworkLogger: NetworkLoggerProtocol {
    public init() {}

    public func log(
        urlRequest: URLRequest,
        response: HTTPURLResponse?,
        dataResponse: Data?,
        error: Error?
    ) {
        #if DEBUG
            print("🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️ Request 🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️")
            if let url = urlRequest.url {
                print("🔗🔗🔗 URL: \(url)")
            }

            if let httpMethod = urlRequest.httpMethod {
                print("👉👉👉 method: \(httpMethod)")
            }

            if let headers = urlRequest.allHTTPHeaderFields {
                print("⏰⏰⏰ Headers: \(headers)")
            }

            if let body = try? JSONSerialization.jsonObject(
                with: urlRequest.httpBody ?? Data(),
                options: .fragmentsAllowed
            ) {
                print("🧠🧠🧠 Body: \(String(describing: body))")
            }

            // swiftlint: disable line_length
            if let response {
                print("📲📲📲 StatusCode: \(response.statusCode), description: \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
                print("⏰⏰⏰ Headers_Response: \(String(describing: response.allHeaderFields))")
            }
            // swiftlint: enable line_length

            if let error {
                print("❌❌❌ ERROR: \(error.localizedDescription)")
            }

            if let dataResponse, let json = try? JSONSerialization.jsonObject(with: dataResponse, options: .fragmentsAllowed) {
                print("✅✅✅ ResponseData: \(json)")
            }

            print("🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️ End Request 🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️")
        #endif
    }
}
