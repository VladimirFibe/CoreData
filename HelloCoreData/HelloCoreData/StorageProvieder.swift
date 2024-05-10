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
    func save() {
        do {
            try persistentContainer.viewContext.save()
            print("Movie saved succesfully")
        } catch {
            persistentContainer.viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    func save(_ name: String) {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.name = name
        save()
    }
    
    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch movies: \(error)")
            return []
        }
    }
    
    func delete(_ movie: Movie) {
        persistentContainer.viewContext.delete(movie)
        save()
    }
}
