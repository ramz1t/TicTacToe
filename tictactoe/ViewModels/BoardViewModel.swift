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
    var boardSize = 3
    var winner: SquareSymbol? = nil
    
    func initGame() {
        isOver = false
        isX = true
        winner = nil
        boardIsFull = false
        board.create(boardSize)
    }
    
    func makeMove(square: Square) {
        // Checking that the move can be done
        guard !isOver else { return }
        guard square.symbol == nil else { return }
        
        // Changing the square symbol
        board.squares[square.i].symbol = isX ? .cross : .circle
        
        var squares = board.squares
        
        for _ in 0...1 {
            
            // Check horizontals
            for i in 0...2 {
                var s = 0
                for j in 0...2 {
                    s = checkSquare(squares[i * boardSize + j], s)
                }
                checkSum(s)
            }
            
            // Check primary diagonal
            var s = 0
            for i in 0...2 {
                s = checkSquare(squares[i * boardSize + i], s)
            }
            checkSum(s)
            
            rotateMatrixClockwise(matrix: &squares, n: boardSize)

        }
        
        // Switching active user
        isX.toggle()
        
        // Checking if any empty squares left
        boardIsFull = !board.squares.contains { $0.symbol == nil  }
    }
    
    func checkSum(_ sum: Int) {
        if sum == -boardSize {
            winner = .cross
        } else if sum == boardSize {
            winner = .circle
        }
        
        if winner != nil {
            isOver = true
        }
    }
    
    func checkSquare(_ square: Square, _ s: Int) -> Int {
        switch square.symbol {
        case .circle:
            return s + 1
        case .cross:
            return s - 1
        case .none: 
            return s
        }
    }
    
    func rotateMatrixClockwise(matrix: inout [Square], n: Int) {
        for layer in 0..<n/2 {
            let first = layer
            let last = n - 1 - layer
            
            for i in first..<last {
                let offset = i - first
                let top = matrix[first * n + i]
                
                // Move values from the right to the top
                matrix[first * n + i] = matrix[(last - offset) * n + first]
                
                // Move values from the bottom to the right
                matrix[(last - offset) * n + first] = matrix[last * n + (last - offset)]
                
                // Move values from the left to the bottom
                matrix[last * n + (last - offset)] = matrix[i * n + last]
                
                // Move values from the top to the left
                matrix[i * n + last] = top
            }
        }
    }
    
}
