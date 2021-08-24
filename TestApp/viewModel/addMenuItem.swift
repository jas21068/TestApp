//
//  addMenuItem.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//

import SwiftUI
import CoreData

struct addMenuItem: View {
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingConfirmation = false
    @State private var wordCount: Int = 0
    @State private var  name = ""
    @State private var  desc = ""
    
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    @State private var showImagePicker = false
    @State private var image = Image(systemName: "person.circle.fill")
    @State private var data: Data?
    @State private var optionalData = UIImage(systemName: "person.circle.fill")?.jpegData(compressionQuality: 1)
    
    var body: some View {
        NavigationView {
            Form {
                
                //image section
                Section{
                    HStack{
                        Button(action:{showImagePicker = true}
                        ){ image
                            .resizable()
                            .frame(width: 70, height: 70)
                            .padding(.trailing, 40)}
                        
                        //ImagePickerSection
                        Button(action: {
                            showImagePicker = true
                        }) { Text("Select an image") }}.padding(.top, 5)
                        .padding(.bottom, 5)}
                
                //TextField Section name
                VStack{
                    Text("Name")
                        .frame(width: 310, height: 20, alignment: .leading)
                        .font(.headline)
                        .padding(.top, 7)
                    
                    Section {
                        
                        TextField("", text: $name)
                    }
                }
                //TextField Section
                
                Section {
                    VStack{
                        
                        Text("Description")
                            .frame(width: 310, height: 20, alignment: .leading)
                            .font(.headline)
                            .padding(.top, 7)
                        
                        
                        
                        
                        
                        TextEditor(text: $desc)
                            .font(.body)
                            
                            .onChange(of: desc) { value in
                                let words = desc.split { $0 == " " || $0.isNewline }
                                self.wordCount = words.count
                                
                            }
                    }
                }
                //Save Section
                Section {
                    Button("Save") {
                        if name.isEmpty{
                            self.showingConfirmation = true
                        }
                        
                        else
                        {
                            let newItem = MenuItem(context: self.moc)
                            
                            newItem.name = self.name
                            newItem.imageData = data
                            newItem.desc = desc
                            newItem.id = UUID()
                            
                            try? self.moc.save()
                            // add the item
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    
                }
                
            }.navigationBarTitle("Add Category")
            .alert(isPresented: $showingConfirmation) {
                Alert(title: Text("Notice!"), message: Text("Please fill name"), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(data: $data)
            }
        }
    }
    
    func loadImage() {
        guard let data = data else { return }
        
        image = Image(uiImage: UIImage(data: data) ?? UIImage(systemName: "person.circle.fill")!)
    }
}

struct addMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        addMenuItem()
    }
}
