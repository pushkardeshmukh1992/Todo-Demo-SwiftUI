//
//  AddTodoView.swift
//  Todo App SwiftUI
//
//  Created by Pushkar Deshmukh on 18/08/23.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: Properties
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    let priorities = ["High", "Normal", "Low"]
    
    // MARK: BODY
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // MARK: TODO Name
                    TextField("Todo", text: $name)
                    
                    // MARK: TODO Priority
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button("Save") {
                        if name != "" {
                            print("Save a new todo item")
                            let todo = Todo(context: viewContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do {
                                try viewContext.save()
                                print("nnew todo", todo)
                            } catch {
                                print(error)
                            }
                        } else {
                            errorShowing = true
                            errorTitle = "Invalid Name"
                            errorMessage = "Make sure to enter something for\nthe new todo item."
                            return
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
                       
                    }
                    
                   
                } //: Form
                Spacer()
                
            } //: VStack
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
            })
            .background(Color.purple)
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            }
        } //: Navigation
    }

}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
