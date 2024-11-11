import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }

            ItineraryView()
                .tabItem {
                    Label("Itinerary", systemImage: "calendar")
                }

            WeatherView()
                .tabItem {
                    Label("Weather", systemImage: "cloud.sun.fill")
                }

            PlacesView()
                .tabItem {
                    Label("Places", systemImage: "star.fill")
                }

            ExpenseView()
                .tabItem {
                    Label("Expenses", systemImage: "creditcard.fill")
                }
        }
    }
}
