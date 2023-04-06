//
//  Book.swift
//  BooksKeeper
//
//  Created by Olga Yurchuk on 06.04.2023.
//
import RealmSwift
import Foundation

class Book: Object {
    @Persisted var name: String = ""
    @Persisted var date = Date()
}
