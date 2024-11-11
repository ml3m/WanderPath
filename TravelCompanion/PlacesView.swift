import SwiftUI

struct PlacesView: View {
    let places = ["Bran Castle", "Peles Castle", "The Black Sea", "Romanian Athenaeum"]
    
    var body: some View {
        NavigationView {
            List(places, id: \.self) { place in
                Text(place)
            }
            .navigationTitle("Places to Visit")
        }
    }
}
