//
//  AddView.swift
//  NoteApp
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext)private var viewContext
    @Environment(\.dismiss)private var dismiss
    @State private var title = ""
    @State private var content = ""
    @State private var selectdate = Date()
    
    var body: some View {
        NavigationView{
            Form {
                Section(header:Text("Add note"))
                {
                    TextField("enter tiltlr",text:$title)
                    TextField("enter content",text:$content)
                }
                Section(header:Text("enawlect date"))
                {
                    DatePicker("select date",selection: $selectdate)
                }}.navigationBarTitle("add new note",displayMode: .inline)
                    .navigationBarItems(leading: Button("cancel")
                                        {
                        dismiss()
                    },trailing:Button("save"){
                        addNotes()
                        dismiss()
                    }.disabled(title.isEmpty||content.isEmpty))
            }
        
    }
    func addNotes()
    {
        let notes = Note(context: viewContext)
        notes.title = title
        notes.contenet  = content
        notes.datecreated = selectdate
        do{
            try viewContext.save()
        }catch{
            print("errpr in saving")
        }
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
