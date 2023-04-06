//
//  BooksListViewModel.swift
//  BooksKeeper
//
//  Created by Olga Yurchuk on 06.04.2023.
//

import Foundation

protocol BooksListViewModelProtocol {
    var books: [Book] {get set}
}

class BooksListViewModel: BooksListViewModelProtocol {
    var books: [Book] = []
    
    
}
