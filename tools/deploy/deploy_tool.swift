import Foundation

public class DeployTool {
    public static func deploy() {
        print("Deploying the project...")
        DeployHelper.prepareDeployment()
        let result = executeShellCommand("swift package archive-source --output project.zip")
        if result == 0 {
            print("Deployment archive created.")
            DeployHelper.finalizeDeployment()
        } else {
            print("Deployment failed with exit code \(result).")
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
