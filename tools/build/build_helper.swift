import Foundation

public class BuildHelper {
    public static func cleanBuild() {
        print("Cleaning build artifacts...")
        let result = executeShellCommand("swift package clean")
        if result == 0 {
            print("Clean succeeded.")
        } else {
            print("Clean failed with exit code \(result).")
        }
    }

    public static func configureBuild() {
        print("Configuring build settings...")
        // Configuration logic, e.g., setting environment variables
        let result = setEnvironmentVariable("SWIFT_OPTIMIZATION_LEVEL", value: "-O")
        if result {
            print("Build configuration succeeded.")
        } else {
            print("Build configuration failed.")
        }
    }

    private static func executeShellCommand(_ command: String) -> Int32 {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }

    private static func setEnvironmentVariable(_ key: String, value: String) -> Bool {
        setenv(key, value, 1)
        return getenv(key) != nil
    }
}
