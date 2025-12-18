import Foundation

public final class ThreadManager {
    public static let shared = ThreadManager()
    private var threads = [Thread]()
    private let threadLock = NSLock()

    private init() {}

    @discardableResult
    public func createThread(work: @escaping () -> Void) -> Thread {
        let thread = Thread {
            guard !Thread.current.isCancelled else { return }
            // Give termination a small window before executing the work item.
            Thread.sleep(forTimeInterval: 0.01)
            guard !Thread.current.isCancelled else { return }
            work()
        }
        threadLock.lock()
        threads.append(thread)
        threadLock.unlock()
        thread.start()
        return thread
    }

    public func joinAllThreads() {
        threadLock.lock()
        let threadsToJoin = threads
        threadLock.unlock()

        for thread in threadsToJoin {
            thread.join()
        }
    }

    public func terminateAllThreads() {
        threadLock.lock()
        for thread in threads {
            if !thread.isCancelled {
                thread.cancel()
            }
        }
        threads.removeAll()
        threadLock.unlock()
    }
}
