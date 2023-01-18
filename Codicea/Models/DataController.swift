// Data controller to save user input
import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "UserQuiz")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
