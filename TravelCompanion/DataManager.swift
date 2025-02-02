import Foundation
import Firebase
import FirebaseFirestore

class DataManager {
    static let shared = DataManager()
    private let db = Firestore.firestore()
    private var userId: String?
    private init() { }
    
    func setUserId(_ userId: String) {
        self.userId = userId
    }
    
    // MARK: - Save and Load Itinerary
    
    func saveItinerary(_ items: [String]) {
        guard let userId = userId else { return }
        let document = db.collection("users").document(userId)
        
        document.setData(["itinerary": ["items": items]], merge: true) { error in
            if let error = error {
                Logger.shared.log("Error saving itinerary: \(error.localizedDescription)")
            } else {
                Logger.shared.log("Itinerary saved successfully")
            }
        }
    }
    
    func loadItinerary(completion: @escaping ([String]) -> Void) {
        guard let userId = userId else {
            completion([]) 
            return
        }
        
        let document = db.collection("users").document(userId)
        
        document.getDocument { (snapshot, error) in
            if let error = error {
                Logger.shared.log("Error loading itinerary: \(error.localizedDescription)")
                completion([])
            } else if let data = snapshot?.data(),
                      let itineraryData = data["itinerary"] as? [String: Any],
                      let items = itineraryData["items"] as? [String] {
                completion(items)
            } else {
                completion([])
            }
        }
    }
    
    // MARK: - Save and Load Expenses
    
    func saveExpenses(_ expenses: [Expense]) {
        guard let userId = userId else { return }
        let document = db.collection("users").document(userId)
        
        document.setData(["expenses": expenses.map { $0.dictionary }], merge: true) { error in
            if let error = error {
                Logger.shared.log("Error saving expenses: \(error.localizedDescription)")
            } else {
                Logger.shared.log("Expenses saved successfully")
            }
        }
    }
    
    func loadExpenses(completion: @escaping ([Expense]) -> Void) {
        guard let userId = userId else {
            completion([])
            return
        }
        
        let document = db.collection("users").document(userId)
        
        document.getDocument { (snapshot, error) in
            if let error = error {
                Logger.shared.log("Error loading expenses: \(error.localizedDescription)")
                completion([])
            } else if let data = snapshot?.data(), let expensesData = data["expenses"] as? [[String: Any]] {
                let expenses = expensesData.compactMap { Expense(dictionary: $0) }
                completion(expenses)
            } else {
                completion([])
            }
        }
    }
}

// MARK: - Expense Model Extension

extension Expense {
    var dictionary: [String: Any] {
        return [
            "name": name,
            "amount": amount
        ]
    }
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
              let amount = dictionary["amount"] as? Double else {
            return nil
        }
        self.init(name: name, amount: amount)
    }
}
