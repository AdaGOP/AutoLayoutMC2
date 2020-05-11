//
//  MyImagePicker.swift
//  AutoLayout
//
//  Created by Handy Handy on 11/05/20.
//  Copyright © 2020 khoirunnisa. All rights reserved.
//

import UIKit

// MARK: - ALImagePickerDelegate
/// The protocol was to receive the image from your photo gallery
protocol ALImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

// MARK: - ALImagePicker
/// The ALImagePicker from AutoLayoutImagePicker, "AutoLayout" is the app name.
class ALImagePicker: NSObject {
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ALImagePickerDelegate?
    
    /// The init used to create picker controller and set the ALImagePickerDelegate and presentationController with the delegate
    init(presentationController: UIViewController, delegate: ALImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
    }
    
    /// This function is used for generate action in alert, it will based on the source type, so we check the availability in here, if the source type is not available, return nil
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    /// This function will be called from view controller, to trigger the action sheet.
    public func present(from sourceView: UIView) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    /// This function will be trigger when some picture is selected.
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(image: image)
    }
    
}

// MARK: - UIImagePickerControllerDelegate
extension ALImagePicker: UIImagePickerControllerDelegate {
    
    /// This function will be trigger when UIImagePickerController canceled and notify the ALImagePickerDelegate to return nil on the ALImagePickerDelegate.
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    /// This function will be trigger when some picture is selected and notify the ALImagePickerDelegate to handle the image.
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

// MARK: - UINavigationControllerDelegate
extension ALImagePicker: UINavigationControllerDelegate {}
