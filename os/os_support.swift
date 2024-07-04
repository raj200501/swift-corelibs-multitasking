import Foundation

public class OSSupport {
    public static func isSupportedOS() -> Bool {
        #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(Linux)
        return true
        #else
        return false
        #endif
    }

    public static func getOSName() -> String {
        #if os(macOS)
        return "macOS"
        #elseif os(iOS)
        return "iOS"
        #elseif os(tvOS)
        return "tvOS"
        #elseif os(watchOS)
        return "watchOS"
        #elseif os(Linux)
        return "Linux"
        #else
        return "Unknown"
        #endif
    }
}
