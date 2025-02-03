//
//  EditView.swift
//  NoteApp
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext)private var viewContext
    @Environment(\.dismiss)private var dismiss
    @ObservedObject var note :Note
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
                    .navigationBarItems(leading: Button("cancel"){
                        dismiss()
                    },trailing:Button("save"){
                        note.title = title
                        note.contenet = content
                        note.datecreated = selectdate
                        EditNotes()
                        dismiss()
                    }.disabled(title.isEmpty||content.isEmpty))
                    .onAppear{
                        title = note.title ?? ""
                        content = note.contenet ?? ""
                        selectdate = note.datecreated ?? Date()
                    }}
    }
    func EditNotes()
    {
        do{
            try viewContext.save()
        }catch{print("error in saving\(error)")}
    }
}


