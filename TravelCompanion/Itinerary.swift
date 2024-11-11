import Foundation
import CoreData

@objc(Itinerary)
class Itinerary: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var destination: String
    @NSManaged var startDate: Date
    @NSManaged var endDate: Date
    @NSManaged var activities: [String]
}
