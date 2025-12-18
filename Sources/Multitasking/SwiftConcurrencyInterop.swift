import Foundation
import _Concurrency

#if canImport(Combine)
import Combine
#endif

public enum SwiftConcurrencyInterop {
    public static func asyncToCombine() -> MultitaskingFuture<String> {
        return MultitaskingFuture { promise in
            _Concurrency.Task {
                let result = await performAsyncTask()
                promise(result)
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
