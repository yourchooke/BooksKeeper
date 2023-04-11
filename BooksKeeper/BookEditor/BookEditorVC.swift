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
    @IBOutlet weak var actionButtonBottomConstraint: NSLayoutConstraint!
    
    var book: Book?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookNameTextField.delegate = self
        setupEditor()
        
        // Notifications for when the keyboard opens/closes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    func setupEditor(){
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Date picker bounds
        bookDatePicker.minimumDate = Date()
        bookDatePicker.maximumDate = Calendar.current.date(byAdding: .month, value: 3, to: Date())
        
        // Editing&Adding
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
        let trimmedString = bookNameTextField.text?.trimingLeadingSpaces()
        bookNameTextField.text = trimmedString
        guard
            let name = bookNameTextField.text, !name.isEmpty, name != " "
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
//  MARK: Keyboard vs. button issue
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if bookNameTextField.isEditing {
            moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.actionButtonBottomConstraint, keyboardWillShow: true)
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.actionButtonBottomConstraint, keyboardWillShow: false)
    }
    
    func moveViewWithKeyboard(notification: NSNotification, viewBottomConstraint: NSLayoutConstraint, keyboardWillShow: Bool) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
        if keyboardWillShow {
            let safeAreaExists = (self.view?.window?.safeAreaInsets.bottom != 0)
            let bottomConstant: CGFloat = 20
            viewBottomConstraint.constant = keyboardHeight + (safeAreaExists ? 0 : bottomConstant)
        } else {
            viewBottomConstraint.constant = 20
        }
        let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        animator.startAnimation()
    }
}
