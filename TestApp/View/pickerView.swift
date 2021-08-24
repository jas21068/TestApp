//
//  pickerView.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//



import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var data: Data?
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.data = uiImage.jpegData(compressionQuality: 1)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

