import Foundation

public class AsyncAwaitSupport {
    public static func performAsyncTask() async {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                // Perform async work
                continuation.resume()
            }
        }
    }

    public static func performTaskWithResult() async -> String {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                // Simulate work and return a result
                let result = "Task Completed"
                continuation.resume(returning: result)
            }
        }
    }
}
