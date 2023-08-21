//
//  ContentView.swift
//  Todo App SwiftUI
//
//  Created by Pushkar Deshmukh on 18/08/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: Properties
    @State private var showingAddTodoView = false
    
    // MARK: Body
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    //    var body: some View {
    //        NavigationView {
    //            List {
    //                ForEach(items) { item in
    //                    NavigationLink {
    //                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
    //                    } label: {
    //                        Text(item.timestamp!, formatter: itemFormatter)
    //                    }
    //                }
    //                .onDelete(perform: deleteItems)
    //            }
    //            .toolbar {
    //                ToolbarItem(placement: .navigationBarTrailing) {
    //                    EditButton()
    //                }
    //                ToolbarItem {
    //                    Button(action: addItem) {
    //                        Label("Add Item", systemImage: "plus")
    //                    }
    //                }
    //            }
    //            Text("Select an item")
    //        }
    //    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todos, id: \.self) { todo in
                    HStack {
                        Text(todo.name ?? "Unknnown")
                        Spacer()
                        Text(todo.priority ?? "Unknown")
                    }
                }//: Foreach
                .onDelete(perform: deleteTodo)
                
            } //: List
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                print("Add tapped")
                self.showingAddTodoView.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddTodoView) {
                AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
    }
    
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
    // MARK: Functions
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        
        return ContentView().environment(\.managedObjectContext, context)
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
