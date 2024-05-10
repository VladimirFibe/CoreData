import SwiftUI

struct ContentView: View {
    let provider: StorageProvieder
    @State private var name = ""
    var body: some View {
        VStack {
            TextField("Name", text: $name)
            Button("Save") {
                provider.save(name)
            }
            .disabled(name.isEmpty)
        }
        .padding()
    }
}
//
//#Preview {
//    ContentView()
//}
