//
//  ViewController.swift
//  AutoLayout
//
//  Created by khoirunnisa' rizky noor fatimah on 07/05/20.
//  Copyright © 2020 khoirunnisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imagePicker: ALImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imagePicker = ALImagePicker(presentationController: self, delegate: self)
        
    }

    @IBAction func uploadDidTap(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func shareDidTap(_ sender: UIButton) {
           
    }
       
}

extension ViewController: ALImagePickerDelegate {
    func didSelect(image: UIImage?) {
        
    }
}

