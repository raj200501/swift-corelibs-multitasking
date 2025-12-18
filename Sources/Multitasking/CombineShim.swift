import Foundation

#if canImport(Combine)
import Combine
public typealias MultitaskingFuture<Output> = Future<Output, Never>
public typealias MultitaskingPublisher<Output> = AnyPublisher<Output, Never>
#else
// Minimal Combine-like primitives for Linux compatibility
public final class MultitaskingFuture<Output> {
    private let work: (@escaping (Output) -> Void) -> Void

    public init(_ work: @escaping (@escaping (Output) -> Void) -> Void) {
        self.work = work
    }

    public func sink(_ receiveValue: @escaping (Output) -> Void) {
        work(receiveValue)
    }

    public func flatMap<T>(_ transform: @escaping (Output) -> MultitaskingFuture<T>) -> MultitaskingPublisher<T> {
        MultitaskingPublisher<T> { callback in
            self.sink { value in
                transform(value).sink { transformed in
                    callback(transformed)
                }
            }
        }
    }
}

public final class MultitaskingPublisher<Output> {
    private let work: (@escaping (Output) -> Void) -> Void

    public init(_ work: @escaping (@escaping (Output) -> Void) -> Void) {
        self.work = work
    }

    public func sink(_ receiveValue: @escaping (Output) -> Void) {
        work(receiveValue)
    }

    public func eraseToAnyPublisher() -> MultitaskingPublisher<Output> { self }
}
#endif
