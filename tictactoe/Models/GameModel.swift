//
//  GameModel.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 21.10.2023.
//

import Foundation

enum GameState {
    case moveX, moveO, fullBoard, winnerX, winnerO
}

struct GameModel {
    var boardSize = 3
    var winLine = [Square]()
    var scoreX = 0
    var scoreO = 0
    var gameState: GameState = .moveX
    var board = [Square]()
    
    mutating func initBoard() {
        board.removeAll()
        for _ in 0 ..< boardSize * boardSize {
            board.append(Square())
        }
    }
    
    mutating func newRound() {
        gameState = .moveX
        initBoard()
    }
    
    mutating func resetScore() {
        scoreX = 0
        scoreO = 0
    }
    
    mutating func makeMove(index: Int) {
        // Checking that the move can be done
        guard board[index].symbol == nil else { return }
        
        // Changing the square symbol
        board[index].symbol = gameState == .moveX ? .cross : .circle
        
        var squares = board
        
        // Cheching if move makes a win
        
        /*
         !!! Checking win logic:
         
         Each line (v, h, d) has an initial lineSum 0
         If square in a line is X, then sum is increased by 1, if O then decreased by 1
         If lineSum is either +3 or -3, then the game is over
         
         !!! Checking win order:
         
         1. Checking horizontals
         ---
         ---
         ---
         
         2. Checking primary diagonal
         \..
         .\.
         ..\
         
         3. Rotating matrix clockwise and repeating steps 1 and 2
         
         !!! Winning line logic
         
         While line is checking, current squares are placed to winLine array
         If the line is winnable, all loops end and winLine contains current winnable line
         This winLine then uses for visual indication of game end
         
         */
        
    outer: for _ in 0...1 {
        var lineSum = 0
        
        // Check horizontals
        for y in 0...2 {
            lineSum = 0
            winLine = []
            
            for x in 0...2 {
                let square = squares[y * boardSize + x]
                checkSquare(square, &lineSum)
                winLine.append(square)
            }
            
            if checkSum(lineSum) { break outer }
        }
        
        // Check primary diagonal
        lineSum = 0
        winLine = []
        
        for i in 0...2 {
            let square = squares[i * boardSize + i]
            checkSquare(square, &lineSum)
            winLine.append(square)
        }
        
        if checkSum(lineSum) { break outer }
        
        winLine = []
        
        // Rotating the matrix for next checks
        rotateMatrixClockwise(matrix: &squares, n: boardSize)
        
    }
        
        // Switching active user
        if gameState == .moveX {
            gameState = .moveO
        } else if gameState == .moveO {
            gameState = .moveX
        }
        
        // Checking if any empty squares left
        if !board.contains(where: { $0.symbol == nil  }) {
            gameState = .fullBoard
        }
    
    }
    
    mutating private func checkSum(_ sum: Int) -> Bool {
        if sum == -boardSize {
            gameState = .winnerX
            scoreX += 1
            return true
        } else if sum == boardSize {
            gameState = .winnerO
            scoreO += 1
            return true
        }
        
        return false
    }
    
    private func checkSquare(_ square: Square, _ s: inout Int) {
        switch square.symbol {
        case .circle:
            s += 1
            break
        case .cross:
            s -= 1
            break
        case .none:
            return
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
