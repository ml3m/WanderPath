import SwiftUI

struct LogView: View {
    @State private var logs: String = ""
    
    var body: some View {
        ScrollView {
            Text(logs)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Logs")
        .onAppear {
            logs = Logger.shared.retrieveLogs() ?? "No logs available"
        }
    }
}
