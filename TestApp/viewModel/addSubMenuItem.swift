//
//  addSubMenuItem.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//

import SwiftUI

struct addSubMenuItem: View {
    @Environment(\.managedObjectContext) var moc
   
    @ObservedObject var menuItem:MenuItem
    @State private var wordCount: Int = 0
    @State private var newSubItems = ""
    @State private var newSubPrice = ""
    @State private var Description = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var showingConfirmation = false
    
    @State private var showImagePicker = false
    
    @State private var image = Image(systemName: "person.circle.fill")
    @State private var data: Data?

    
    var body: some View {
        NavigationView{
        Form{
            
            //item image section
            Section{
                HStack{
                    Button(action:{showImagePicker = true}){
                        image
                            .resizable()
                            .frame(width: 70, height: 70)
                            .padding(.trailing, 40)}
            
            //choose image section
                Button(action: {showImagePicker = true}) {
                    Text("Select an image")}}}
            
            
           //itemname section
            VStack{
            Text("New Item")
                .frame(width: 310, height: 20, alignment: .leading)
                .font(.headline)
                .padding(.top, 7)
            Section{
                TextField("", text: self.$newSubItems)}}
            
            
            
            //item price
            
            VStack{
                Text("Price")
                    .frame(width: 310, height: 20, alignment: .leading)
                    .font(.headline)
                    .padding(.top, 7)
                    
            Section{
                TextField("", text: self.$newSubPrice)
                    .keyboardType(.numberPad)
            }}
            
            //Item Description
            Section {
            VStack{
                Text("Description")
                    .frame(width: 310, height: 20, alignment: .leading)
                    .font(.headline)
                    .padding(.top, 7)
                       TextEditor(text: $Description)
                           .font(.body)
                           .onChange(of: Description) { value in
                               let words = Description.split { $0 == " " || $0.isNewline }
                               self.wordCount = words.count}}}
            //Save Button

                Button(action: {
                    
                    if newSubItems.isEmpty{
                        self.showingConfirmation = true
                    }
                    else if newSubPrice.isEmpty{
                        self.showingConfirmation = true
                    }
                    else if Description.isEmpty{
                        self.showingConfirmation = true
                    }
                    
                    else{
                    
                    let newSubItems = SubMenuItem(context: self.moc)
                    newSubItems.subname = self.newSubItems
                    newSubItems.price=self.newSubPrice
                    newSubItems.imageData=self.data
                    newSubItems.about=self.Description
                        newSubItems.id=UUID()
                    self.newSubItems = ""
                    self.menuItem.addToSubItems(newSubItems)
                   
                    try? self.moc.save()
                    
                    self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }) {
                    Text("Save")
                        .multilineTextAlignment(.center)
                }
            
        }
        .navigationBarTitle("Add New Item")
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(data: $data)
        }
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Notice!"), message: Text("Please fill all fields"), dismissButton: .default(Text("OK")))
        }
            
        }
            
        
    }
    
    func loadImage() {
        guard let data = data else { return }
        
        image = Image(uiImage: UIImage(data: data) ?? UIImage(systemName: "person.circle.fill")!)
    }
}
