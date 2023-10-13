//
//  BoardModel.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import Foundation

struct Board {
    var squares = [Square]()
    
    mutating func create(_ size: Int) {
        squares = {
            var squares = [Square]()
            for i in 0..<size*size {
                squares.append(Square(i: i))
            }
            return squares
        }()
    }
}
