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
        setupEditor()

    }
    
    func setupEditor(){
        navigationController?.navigationBar.prefersLargeTitles = true
        if let editingBook = book {
            self.title = "Edit info"
            actionButton.setTitle("Edit", for: .normal)
            bookNameTextField.text = editingBook.name
            bookDatePicker.date = editingBook.date
        } else {
            actionButton.isEnabled = false
            bookNameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
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
                book = Book(value: [bookNameTextField.text!, bookDatePicker.date] as [Any])
                if let _ = book {StorageManager.shared.save(book!)}
            } else {
                if let _ = book {
                    StorageManager.shared.edit(
                        book!,
                        newText: bookNameTextField.text!,
                        newDate: bookDatePicker.date
                    )
                }
            }
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
    

}
