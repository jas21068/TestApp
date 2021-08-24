//
//  ContentView.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//


//THIS VIEW IS THE STARTING VIEW

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var showEdit = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: MenuItem.entity(), sortDescriptors: [])
    //Fetching Data From Core Data Module
    var menuItem: FetchedResults<MenuItem>
    @State private var showingAddScreen = false
    @State private var showingEditScreen = false

    var body: some View {
        NavigationView{
            List {
                ForEach(self.menuItem, id: \.self) { (menuItem:MenuItem) in
                    //Navigation Link to Detail View(Sub Items inside)
                    NavigationLink(destination: detailView(menuItem:menuItem).environment(\.managedObjectContext, self.moc))  {
                        
                        FirstList(menuItem:menuItem).environment(\.managedObjectContext, self.moc)
                            //Navigation link linked to context menu to edit screen
                            .background(
                                NavigationLink(destination: editMenuCategory(menuItem:menuItem).environment(\.managedObjectContext, self.moc), isActive: $showEdit){
                                    EmptyView()
                                }
                            )
                            //Context Menu Link
                            .contextMenu{
                                Button(action: { self.showEdit = true }) {
                                    Label("Edit", systemImage: "pencil")
                                }
                            }
                    }
                }
                .onDelete(perform: deleteMenuItem)

            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    VStack{
                        Text("Menu Categories")
                            .font(.headline)
                    }
                }
            }
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
            //add menu pop up view
            .sheet(isPresented: $showingAddScreen) {
                addMenuItem().environment(\.managedObjectContext, self.moc)
            }
        }
    }
//Deleting Items
    func deleteMenuItem(at offsets: IndexSet) {
        for offset in offsets {
            // find this item in our fetch request
            let items = menuItem[offset]
            
            
            
            // delete it from the context
            moc.delete(items)
        }
        
        // save the context
        try? moc.save()
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
