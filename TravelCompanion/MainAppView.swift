import SwiftUI
import Firebase
import FirebaseAuth

struct MainAppView: View {
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
        .navigationTitle("Travel Companion")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Logout") {
                    logout()
                }
            }
        }
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            // Go back to AuthView on sign out
            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: AuthView())
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
