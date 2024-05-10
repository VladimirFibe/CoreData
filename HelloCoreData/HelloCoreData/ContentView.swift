import SwiftUI

struct ContentView: View {
    let provider: StorageProvieder
    @State private var name = ""
    
    @State private var movies: [Movie] = []
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(movies) { movie in
                        NavigationLink {
                            EditMovie(provider: provider, movie: movie)
                        } label: {
                            Text(movie.nameString)
                        }
                    }.onDelete(perform: deleteMovies)
                }
                .listStyle(.plain)
                TextField("Name", text: $name)
                Button("Save") {
                    provider.save(name)
                    name = ""
                    movies = provider.getAllMovies()
                }
                .disabled(name.isEmpty)
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Button("Reload") {
                        movies = []
                        movies = provider.getAllMovies()
                    }
                }
            }
        }
        .onAppear {
            movies = provider.getAllMovies()
        }
    }
    func deleteMovies(_ offsets: IndexSet) {
        for offset in offsets {
            provider.delete(movies[offset])
        }
    }
}

struct EditMovie: View {
    let provider: StorageProvieder
    let movie: Movie
    @State private var name = ""
    var body: some View {
        VStack {
            TextField("Name", text: $name)
            Button("Save") {
                movie.name = name
                provider.save()
            }
        }
        .onAppear {
            name = movie.nameString
        }
    }
}
