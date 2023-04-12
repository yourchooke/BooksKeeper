//
//  BooksListVC.swift
//  BooksKeeper
//
//  Created by Olga Yurchuk on 06.04.2023.
//

import UIKit
import RealmSwift

class BooksListVC: UITableViewController {
    var bookList: Results<Book>!
    var sortingKind: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book list"
        navigationController?.navigationBar.prefersLargeTitles = true
        bookList = StorageManager.shared.realm.objects(Book.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let kind = sortingKind {sortBooks(by: kind)}
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookList.isEmpty {
            let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            emptyLabel.text = "Empty list"
            emptyLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
            emptyLabel.textColor = .lightGray
            emptyLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = emptyLabel
            return 0
        } else {
            self.tableView.backgroundView = nil
            return bookList.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookID", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let book = bookList[indexPath.row]
        content.text = book.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY"
        
        content.secondaryText = dateFormatter.string(from: book.date)
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let book = bookList[indexPath.row]
        performSegue(withIdentifier: "segueToEditor", sender: book)
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let book = bookList[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            StorageManager.shared.delete(book)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editorVC = segue.destination as! BookEditorVC
        editorVC.book = sender as? Book
    }
    // MARK: - Actions
    @IBAction func addButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "segueToEditor", sender: Any?.self )
    }
    
    @IBAction func sortButtonAction(_ sender: Any) {
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        // create an action
        let sortByName: UIAlertAction = UIAlertAction(title: "Sort by name", style: .default) { action -> Void in
            self.sortBooks(by: "name")
            self.sortingKind = "name"

        }

        let sortByDate: UIAlertAction = UIAlertAction(title: "Sort by date", style: .default) { action -> Void in

            self.sortBooks(by: "date")
            self.sortingKind = "date"
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
        actionSheetController.addAction(sortByName)
        actionSheetController.addAction(sortByDate)
        actionSheetController.addAction(cancelAction)

        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
    }
    
    func sortBooks(by key: String) {
        bookList = bookList.sorted(byKeyPath: key, ascending: true)
        tableView.reloadData()
    }

    
}

