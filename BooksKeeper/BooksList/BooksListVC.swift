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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book list"
        navigationController?.navigationBar.prefersLargeTitles = true
        bookList = StorageManager.shared.realm.objects(Book.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookList.count
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editorVC = segue.destination as! BookEditorVC
        editorVC.book = sender as? Book
    }

    @IBAction func addButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "segueToEditor", sender: Any?.self )
    }
    

}
