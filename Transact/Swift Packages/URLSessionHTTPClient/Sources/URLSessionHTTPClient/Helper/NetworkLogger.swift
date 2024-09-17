import Foundation

struct NetworkLogger {
    private init() {}
    static func log(
        urlRequest: URLRequest,
        response: HTTPURLResponse?,
        dataResponse: Data?,
        error: Error?
    ) {
        #if DEBUG
            print("🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️ Request 🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️")
            print("🔗🔗🔗 URL: \(String(describing: urlRequest.url))")
            print("👉👉👉 methods: \(String(describing: urlRequest.httpMethod))")
            print("⏰⏰⏰ Headers: \(String(describing: urlRequest.allHTTPHeaderFields))")

            if let body = try? JSONSerialization.jsonObject(
                with: urlRequest.httpBody ?? Data(),
                options: .fragmentsAllowed
            ) {
                print("🧠🧠🧠 Body: \(String(describing: body))")
            }
        
            if let response {
                print("📲📲📲 StatusCode: \(response.statusCode), description: \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
                print("⏰⏰⏰ Headers_Response: \(String(describing: response.allHeaderFields))")
            }
        
            if let error {
                print("❌❌❌ ERROR: \(error.localizedDescription)")
            }
        
            if let dataResponse, let json = try? JSONSerialization.jsonObject(with: dataResponse, options: .fragmentsAllowed) {
                print("✅✅✅ ResponseData: \(String(describing: json))")
            }
        
            print("🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️ End Request 🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️")
        #endif
    }
}
