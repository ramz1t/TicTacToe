//
//  BoardViewModel.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import Foundation
import Observation

@Observable class GameViewModel {
    var board = Board()
    var isX = true
    var isOver = false
    var boardIsFull = false
    
    func initGame() {
        isOver = false
        isX = true
        boardIsFull = false
        board.create()
    }
    
    func makeMove(square: Square) {
        guard !isOver else { return }
        guard square.symbol == .empty else { return }
        
        let newSymbol: SquareSymbol = isX ? .cross : .circle
        board.squares[square.y][square.x].symbol = newSymbol
        
        isX.toggle()
        boardIsFull = !board.squares.contains { row in
            row.contains { $0.symbol == .empty  }
        }
    }
}
