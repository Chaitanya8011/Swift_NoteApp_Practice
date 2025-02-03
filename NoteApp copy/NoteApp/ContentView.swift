import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Note.entity(), sortDescriptors: [])
    private var notes: FetchedResults<Note>
    
    @State private var showAddView = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(notes) { note in
                        NavigationLink(destination: EditView(note: note)) {
                            VStack(alignment: .leading) {
                                Text(note.title ?? "No Title")
                                    .font(.headline)
                                Text(note.contenet ?? "No Content")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                
                                if let date = note.datecreated {
                                    Text(date.formatted(date: .abbreviated, time: .shortened))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteNote(note)
                                
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("All Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddView()
            }
        }
    }

  private  func deleteNote(_ note: Note) {
        viewContext.delete(note)
        do {
            try viewContext.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
