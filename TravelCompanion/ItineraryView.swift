import SwiftUI

struct ItineraryView: View {
    @State private var itineraryItems: [String] = []
    @State private var newItem = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List(itineraryItems, id: \.self) { item in
                    Text(item)
                }
                
                HStack {
                    TextField("New itinerary item", text: $newItem)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addItem) {
                        Text("Add")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle("Itinerary")
            .onAppear {
                DataManager.shared.loadItinerary { loadedItems in
                    self.itineraryItems = loadedItems
                }
            }
        }
    }
    
    private func addItem() {
        if !newItem.isEmpty {
            itineraryItems.append(newItem)
            DataManager.shared.saveItinerary(itineraryItems)
            Logger.shared.log("Itinerary item added: \(newItem)")
            newItem = ""
        }
    }
}
