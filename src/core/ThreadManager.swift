import Foundation

public class ThreadManager {
    public static let shared = ThreadManager()
    private var threads = [Thread]()
    private let threadLock = NSLock()

    private init() {}

    public func createThread(work: @escaping () -> Void) {
        let thread = Thread {
            work()
        }
        threadLock.lock()
        threads.append(thread)
        threadLock.unlock()
        thread.start()
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
