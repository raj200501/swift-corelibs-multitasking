import Foundation

public class SwiftConcurrencyInterop {
    public static func asyncToCombine() -> Future<String, Never> {
        return Future { promise in
            Task {
                let result = await performAsyncTask()
                promise(.success(result))
            }
        }
    }

    public static func combineToAsync() async -> String {
        let future = CombineSupport.performCombineTask()
        return await withCheckedContinuation { continuation in
            future.sink { result in
                continuation.resume(returning: result)
            }
        }
    }

    private static func performAsyncTask() async -> String {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                let result = "Async Task Result"
                continuation.resume(returning: result)
            }
        }
    }
}
