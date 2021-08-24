//
//  subMenuDetailView.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-19.
//

import SwiftUI

struct subMenuDetailView: View {
    @State private var showEdit = false
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var rating = 3
    @ObservedObject var subMenuItem:SubMenuItem
    @State private var detailSubItems = ""
    @State private var detailSubPrice = ""
    @State private var detailDescription = ""
    @State private var wordCount: Int = 0
    @State private var showImagePicker = false
    @State private var deatailImage = Image(systemName: "person.circle.fill")
    @State private var detailData: Data?
    
    var body: some View {
        
        ScrollView{
        VStack{
            //Image View and Picker
            Button(action:{showImagePicker = true}){
            Image(uiImage: UIImage(data: (self.subMenuItem.wrappedSubImage))!)
                .resizable()
                .frame(width: 236, height: 236)
                .clipShape(Circle())
                .shadow(radius: 13)
                .overlay(Circle().stroke(Color.red, lineWidth: 5))
                .padding(.top,17)
            }
            
            //Editable content
            VStack{
                
                TextField(subMenuItem.wrappedSubName, text: self.$detailSubItems)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                TextField(subMenuItem.wrappedSubPrice, text: self.$detailSubPrice)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
            }
            .padding(.bottom, 21.0)
            .padding(.top, 41)
            Section {
                Text("RATING")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 7.0)
                
                RatingView(rating: $rating)
                
                
            }.padding(.bottom, 17.0)
            
            VStack{
                TextEditor(text: $detailDescription)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .onChange(of: detailDescription) { value in
                        let words = detailDescription.split { $0 == " " || $0.isNewline }
                        self.wordCount = words.count
                    }
            }
        }
        .onAppear {
            self.detailSubItems = self.subMenuItem.wrappedSubName
            self.detailSubPrice = self.subMenuItem.wrappedSubPrice
            self.detailDescription = self.subMenuItem.wrappedSubAbout
            self.detailData=self.subMenuItem.imageData
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    self.subMenuItem.subname = self.detailSubItems
                    self.subMenuItem.about = self.detailDescription
                    self.subMenuItem.price=self.detailSubPrice
                    self.subMenuItem.imageData=self.detailData
                    try? self.moc.save()
                    // update the item
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("update")
                }
            }
            
            ToolbarItem(placement: .principal){
                VStack{
                    Text("Menu Items")
                        .font(.headline)
                }
            }
        }
        .sheet(isPresented: $showImagePicker, onDismiss: UpdateImage) {
            ImagePicker(data: $detailData)
        }
    }
    }
    
    func UpdateImage() {
        guard let data = detailData else { return }
        
        deatailImage = Image(uiImage: UIImage(data: data) ?? UIImage(systemName: "person.circle.fill")!)
        self.subMenuItem.imageData=self.detailData
        try? self.moc.save()
        // update the image
    }
}


