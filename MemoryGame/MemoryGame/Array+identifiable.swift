//
//  Array+identifiable.swift
//  MemoryGame
//
//  Created by Vlad Zamaev on 24.12.2020.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching:  Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
