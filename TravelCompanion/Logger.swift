import Foundation

class Logger {
    static let shared = Logger()
    private let logFileName = "app_log.txt"
    
    private init() { }
    
    private var logFileURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(logFileName)
    }
    
    func log(_ message: String) {
        let timestamp = Date().formatted()
        let logMessage = "[\(timestamp)] \(message)\n"
        
        if let data = logMessage.data(using: .utf8) {
            if FileManager.default.fileExists(atPath: logFileURL.path) {
                if let fileHandle = try? FileHandle(forWritingTo: logFileURL) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                    fileHandle.closeFile()
                }
            } else {
                try? data.write(to: logFileURL)
            }
        }
    }
    
    func retrieveLogs() -> String? {
        return try? String(contentsOf: logFileURL)
    }
}
