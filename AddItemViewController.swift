//
//  addItemViewController.swift
//  groceriesTable
//
//  Created by QwertY on 02.11.2021.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var addItemTextField: UITextField!
    
    var callback : ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addItemTextField.delegate = self
        addItemTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        passDataToMainView()
        return true
    }
    
    func passDataToMainView() {
        if let text = addItemTextField.text {
            callback?(text)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}

