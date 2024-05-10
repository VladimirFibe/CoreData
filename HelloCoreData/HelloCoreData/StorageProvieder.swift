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

extension StorageProvieder {
    func save(_ name: String) {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.name = name
        do {
            try persistentContainer.viewContext.save()
            print("Movie saved succesfully")
        } catch {
            persistentContainer.viewContext.rollback()
            print(error.localizedDescription)
        }
    }
}
