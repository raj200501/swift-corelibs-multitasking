import Foundation

public enum AsyncAwaitSupport {
    public static func performAsyncTask() async {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                continuation.resume()
            }
        }
    }

    public static func performTaskWithResult() async -> String {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                let result = "Task Completed"
                continuation.resume(returning: result)
            }
        }
    }
}
