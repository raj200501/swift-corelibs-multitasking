import Foundation

public class MonitorTool {
    public static func monitor() {
        print("Monitoring the system...")
        MonitorHelper.startMonitoring()
        DispatchQueue.global().async {
            while true {
                MonitorHelper.logResourceUsage()
                sleep(5)
            }
        }
    }
}
