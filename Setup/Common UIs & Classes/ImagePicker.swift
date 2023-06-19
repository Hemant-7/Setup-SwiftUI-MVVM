//
//  ImagePicker.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var isShown: Bool
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, selectedImage: $selectedImage)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        @Binding var isShown: Bool
        @Binding var selectedImage: UIImage?

        init(isShown: Binding<Bool>, selectedImage: Binding<UIImage?>) {
            _isShown = isShown
            _selectedImage = selectedImage
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            selectedImage = info[.originalImage] as? UIImage
            isShown = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
    }
}
