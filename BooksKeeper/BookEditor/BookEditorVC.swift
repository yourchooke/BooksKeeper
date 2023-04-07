//
//  BookEditorVC.swift
//  BooksKeeper
//
//  Created by Olga Yurchuk on 06.04.2023.
//

import UIKit

class BookEditorVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var bookDatePicker: UIDatePicker!
    
    var book: Book?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bookNameTextField.delegate = self
        actionButton.isEnabled = false
        setupEditor()
        bookNameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)

  
    }
    
    func setupEditor(){
        navigationController?.navigationBar.prefersLargeTitles = true
        if book != nil {
            self.title = "Edit info"
            actionButton.titleLabel?.text = "Edit"
        } else {
            self.title = "Add new book"
            actionButton.setTitle("Add", for: .normal)
        }
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        guard
            let name = bookNameTextField.text, !name.isEmpty
        else {
            actionButton.isEnabled = false
            return
        }
        actionButton.isEnabled = true
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        if bookNameTextField.text == nil {
            actionButton.isEnabled = false
        } else {
            if book == nil {
                book = Book(value: [bookNameTextField.text, bookDatePicker.date])
                if let newBook = book {StorageManager.shared.save(book!)}
            }
        }
    }
    

}
