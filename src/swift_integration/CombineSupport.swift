import Combine

public class CombineSupport {
    public static func performCombineTask() -> Future<String, Never> {
        return Future { promise in
            DispatchQueue.global().async {
                // Simulate work and return a result
                let result = "Combine Task Completed"
                promise(.success(result))
            }
        }
    }

    public static func performChainedCombineTasks() -> AnyPublisher<String, Never> {
        return performCombineTask()
            .flatMap { result in
                Future<String, Never> { promise in
                    DispatchQueue.global().async {
                        // Simulate additional work
                        let finalResult = result + " with More Work"
                        promise(.success(finalResult))
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}
