//
//  detailView.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//

import SwiftUI

struct detailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var menuItem:MenuItem
    @State private var detailItem = ""
    @State private var detailDescription = ""
    @State private var detailData : Data?
    @State private var showingAddItemScreen = false
    @State private var showingdetail = false
    @State public var image = Image(systemName: "person.circle.fill")
    @Environment(\.presentationMode) var presentationMode
    @State public var optionalData = UIImage(systemName: "person.circle.fill")?.jpegData(compressionQuality: 1)
    @State private var showImagePicker = false
    @State private var wordCount: Int = 0
    var body: some View {
        VStack{
            
            Section{
                HStack{
                    ZStack{
                    //Image Picker to change Item image
                    Button(action:{showImagePicker = true}){
                        Image(uiImage: UIImage(data: (((self.menuItem.imageData ?? optionalData)!) ))!)
                            .resizable()
                            .frame(width: 86, height: 86)
                            .clipShape(Circle())
                            .shadow(radius: 13)
                            .overlay(Circle().stroke(Color.blue, lineWidth: 5))
                            
                    }
                    }.padding(.leading,7)
                    .padding(.top,13)
                    .padding(.bottom,13)
                    
                    //Section to change name
                    VStack{
                        TextField(menuItem.wrappedName, text: self.$detailItem)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                    }
                    //Save MenuItem
                    VStack{
                        Button(action: {
                            self.menuItem.name = self.detailItem
                            self.menuItem.desc = self.detailDescription
                            
                            self.menuItem.imageData=self.detailData
                            try? self.moc.save()
                            // update the item
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("UPDATE   ")
                        }
                    }
                }.background(Color(red: 237 / 255, green: 235 / 255, blue: 230 / 255))
            }
            List{
                Section {
                    //Displays Menu Items
                    ForEach(self.menuItem.sunItemArray, id: \.self) { (subMenuItem:SubMenuItem) in
                        //Link to menu Items edit and detaol View
                        NavigationLink(destination: subMenuDetailView(subMenuItem:subMenuItem).environment(\.managedObjectContext, self.moc))  {
                            subMenuView(subMenuItem: subMenuItem).environment(\.managedObjectContext, self.moc)
                        }
                    }
                    .onDelete(perform: deleteMenuItem)
                }
            }
            .sheet(isPresented: $showingAddItemScreen) {
                addSubMenuItem( menuItem: menuItem)
            }
            .sheet(isPresented: $showImagePicker, onDismiss: UpdateItemImage) {
                ImagePicker(data: $detailData)
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    self.showingAddItemScreen.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .principal){
                VStack{
                    Text("Menu Items")
                        .font(.headline)
                }
            }
        }
        .onAppear {
            self.detailItem = self.menuItem.wrappedName
            
            self.detailDescription = self.menuItem.wrappedDesc
            self.detailData=self.menuItem.imageData
        }
    }
    
    
    
    func UpdateItemImage() {
        guard let data = detailData else { return }
        
        image = Image(uiImage: UIImage(data: data) ?? UIImage(systemName: "person.circle.fill")!)
        self.menuItem.imageData=self.detailData
        try? self.moc.save()
        // update the image
    }

}

