//
//  FirstList.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//

//The Main page list design
import SwiftUI

struct FirstList: View {
    @Environment(\.managedObjectContext) var moc
    @State private var optionalData = UIImage(systemName: "person.circle.fill")?.jpegData(compressionQuality: 1)
    @ObservedObject var menuItem:MenuItem
    var body: some View {
        
        HStack {
            //Image view
            VStack{
                Image(uiImage: UIImage(data: (self.menuItem.imageData ?? optionalData)!)!)
                    .resizable()
                    .frame(width: 90, height: 95)
            }.padding(.trailing , 15)
            //Name
            VStack(alignment: .leading){
                Text(self.menuItem.wrappedName )
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5.0)
                //description
                Text(self.menuItem.wrappedDesc)
                    .font(.footnote)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.leading)
            }
            .padding(.trailing , 30)
            
        }
    }
}
