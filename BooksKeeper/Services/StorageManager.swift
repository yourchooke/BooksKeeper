//
//  StorageManager.swift
//  BooksKeeper
//
//  Created by Olga Yurchuk on 06.04.2023.
//

import Foundation
import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    func save(_ book: Book) {
        try! realm.write {
            realm.add(book)
        }
    }
    
    func edit(_ book: Book, newText: String, newDate: Date) {
        write {
            book.name = newText
            book.date = newDate
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
    
}
