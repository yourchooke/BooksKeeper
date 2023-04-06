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
    
    func save(_ book: [Book]) {
        try! realm.write {
            realm.add(book)
        }
    }
}
