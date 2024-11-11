import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack {
            Text("Weather Info")
                .font(.largeTitle)
                .padding()
            
            Text("City: Timisoara")
                .font(.title)
            Text("Temperature: 20°C")
                .font(.title2)
            Text("Condition: Sunny")
                .font(.title3)
        }
        .padding()
        .navigationTitle("Weather")
        .onAppear {
            Logger.shared.log("Viewed Weather for Timisoara")
        }
    }
}
