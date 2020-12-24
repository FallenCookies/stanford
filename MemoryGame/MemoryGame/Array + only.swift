//
//  Array + only.swift
//  MemoryGame
//
//  Created by Vlad Zamaev on 24.12.2020.
//

import Foundation

extension Array {
    var only: Element?{
        count == 1 ? first : nil
    }
}
