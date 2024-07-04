import Foundation

public class OSIntegration {
    public static func integrateWithOS() {
        if OSSupport.isSupportedOS() {
            print("Integrating with \(OSSupport.getOSName())")
        } else {
            print("Unsupported OS")
        }
    }
}
