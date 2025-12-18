import Foundation

#if canImport(Combine)
import Combine
#endif

public enum CombineSupport {
    public static func performCombineTask() -> MultitaskingFuture<String> {
        return MultitaskingFuture { promise in
            DispatchQueue.global().async {
                let result = "Combine Task Completed"
                promise(result)
            }
        }
    }

    public static func performChainedCombineTasks() -> MultitaskingPublisher<String> {
        return performCombineTask()
            .flatMap { result in
                MultitaskingFuture<String> { promise in
                    DispatchQueue.global().async {
                        let finalResult = result + " with More Work"
                        promise(finalResult)
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}
