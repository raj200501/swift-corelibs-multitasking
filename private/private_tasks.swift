import Foundation

internal class PrivateTask: Task {
    private let confidentialData: String

    init(name: String, confidentialData: String, work: @escaping () -> Void) {
        self.confidentialData = confidentialData
        super.init(name: name, work: work)
    }

    override func execute() {
        print("Handling confidential data: \(confidentialData)")
        super.execute()
    }
}
