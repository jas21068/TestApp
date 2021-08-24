//
//  editMenuCategory.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-21.
//

import SwiftUI

struct editMenuCategory: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingConfirmation = false
    @State private var wordCount: Int = 0
    @State private var  name = ""
    @State private var  desc = ""
    @State private var showImagePicker = false
    @State private var image = Image(systemName: "person.circle.fill")
    @State private var data: Data?
    @ObservedObject var menuItem:MenuItem
    
    var body: some View {
        Form{
            Section{
                HStack{
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Text("Click here To Change Image")
                    }
                }.padding(.top, 5)
                .padding(.bottom, 5)
            }
            
            //Name Edit
            VStack{
                Text("Name")
                    .frame(width: 310, height: 20, alignment: .leading)
                    .font(.headline)
                    .padding(.top, 7)
                Section {
                    
                    TextField(menuItem.wrappedName, text: $name)
                }
            }
            
            
            //Description Edit
            VStack{
                Text("Description")
                    .frame(width: 310, height: 20, alignment: .leading)
                    .font(.headline)
                    .padding(.top, 7)
                Section {
                    TextEditor(text: $desc)
                        .font(.body)
                        .onChange(of: desc) { value in
                            let words = desc.split { $0 == " " || $0.isNewline }
                            self.wordCount = words.count
                        }
                }
            }
            
          // Update Button Section
            Section {
                Button("Update") {
                    self.menuItem.name = self.name
                    self.menuItem.desc = self.desc
                    self.menuItem.imageData=self.data
                    try? self.moc.save()
                    // add the item
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            self.name = self.menuItem.wrappedName
            self.desc = self.menuItem.wrappedDesc
            self.data=self.menuItem.imageData
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(data: $data)
        }
        .toolbar{
            ToolbarItem(placement: .principal){
                VStack{
                    Text("Edit Menu Category")
                        .font(.headline)
                }
            }
        }

    }
    
    func loadImage() {
        guard let data = data else { return }
        
        image = Image(uiImage: UIImage(data: data) ?? UIImage(systemName: "person.circle.fill")!)
    }
}


