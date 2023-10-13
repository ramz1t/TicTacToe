//
//  BoardModel.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import Foundation

struct Board {
    var squares = [[Square]]()
    
    mutating func create() {
        squares = {
            var squares = [[Square]]()
            for i in 0..<3 {
                var row = [Square]()
                for j in 0..<3 {
                    row.append(Square(x: j, y: i))
                }
                squares.append(row)
            }
            return squares
        }()
    }
}
