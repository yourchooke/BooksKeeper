//
//  Extension + String.swift
//  BooksKeeper
//
//  Created by Olga Yurchuk on 11.04.2023.
//

import Foundation

extension String {
    func trimingLeadingSpaces(using characterSet: CharacterSet = .whitespaces) -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: characterSet) }) else {
            return self
        }

        return String(self[index...])
    }
}
