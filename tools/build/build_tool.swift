import Foundation

public class BuildTool {
    public static func build() {
        print("Building the project...")
        BuildHelper.configureBuild()
        let result = executeShellCommand("swift build")
        if result == 0 {
            print("Build succeeded.")
        } else {
            print("Build failed with exit code \(result).")
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
}
