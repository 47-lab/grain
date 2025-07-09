//
//  ContentView.swift
//  grain
//
//  Created by Yussuf Sassi on 09.07.25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isPresented = false

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ItemEntity.dueAt, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ItemEntity>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.dueAt!, formatter: itemFormatter)")
                    } label: {
                        Text(item.title!)
                    }
                }
                .onDelete(perform: deleteItems)

                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus").fullScreenCover(isPresented: $isPresented, content: CreateNewTaskView.init)
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        isPresented.toggle()
        withAnimation {
            let newItem = ItemEntity(context: viewContext)
            newItem.dueAt = Date()
            newItem.title = "test"
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
