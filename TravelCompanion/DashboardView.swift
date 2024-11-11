import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Travel Companion")
                    .font(.largeTitle)
                    .padding()
                
                NavigationLink(destination: ItineraryView()) {
                    Text("Manage Itinerary")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
                NavigationLink(destination: WeatherView()) {
                    Text("Check Weather")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                NavigationLink(destination: PlacesView()) {
                    Text("Discover Places")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }
}
