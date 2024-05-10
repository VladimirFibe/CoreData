import CoreData

class StorageProvieder {
    let persistentContainer: NSPersistentContainer
    init() {
        persistentContainer = NSPersistentContainer(name: "Hello")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error { fatalError("Core Data store failed to load with error: \(error)")}
            print(storeDescription.url?.absoluteString ?? "")
        }
    }
}
