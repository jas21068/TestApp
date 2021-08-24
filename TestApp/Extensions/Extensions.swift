//
//  Extensions.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-23.
//

import Foundation
import SwiftUI

extension detailView{
    func deleteMenuItem(at offsets: IndexSet) {
        for offset in offsets {
            // find this item in our fetch request
            let items = menuItem.sunItemArray[offset]
            
            
            // delete it from the context
            moc.delete(items)
        }
        
        // save the context
        try? moc.save()
    }
}

extension ImagePicker{
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {  }
}
