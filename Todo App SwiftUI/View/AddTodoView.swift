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
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
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
                        print("Save a new todo item")
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
        } //: Navigation
    }

}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
