//
//  subMenuView.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//

import SwiftUI

struct subMenuView: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var subMenuItem:SubMenuItem
    var body: some View {
        HStack {
            //Image view
            VStack{
                Image(uiImage: UIImage(data: (self.subMenuItem.wrappedSubImage))!)
                    .resizable()
                    .frame(width: 75, height: 85)
            }
            
            //Item Details Section
            VStack{
                Text("\(self.subMenuItem.wrappedSubName)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5.0)
                
                Text("\(self.subMenuItem.wrappedSubAbout)")
                    .font(.footnote)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.leading)
            }
            .padding(.leading, 20.0)
            //Item price
            VStack{
                Text("$\(self.subMenuItem.wrappedSubPrice)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
            }
            
            
        }
    }
}
