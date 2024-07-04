import Foundation

internal struct PrivateConfig {
    static let secretKey = "SECRET_KEY"
    static let apiEndpoint = "https://private.api.endpoint"
    
    static func loadConfig() -> [String: String] {
        return [
            "secretKey": secretKey,
            "apiEndpoint": apiEndpoint
        ]
    }
}
