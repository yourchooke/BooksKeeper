//
//  Book.swift
//  BooksKeeper
//
//  Created by Olga Yurchuk on 06.04.2023.
//
import RealmSwift
import Foundation

class Book {
    @Persisted var name: String
    @Persisted var date: Date
    
    init(name: String, date: Date) {
        self.name = name
        self.date = date
    }
}
