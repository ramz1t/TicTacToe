//
//  BoardViewModel.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import Foundation

final class GameViewModel: ObservableObject {
    @Published var gameModel = GameModel()
    
    var gameState: GameState {
        gameModel.gameState
    }
    
    var scoreX: Int {
        gameModel.scoreX
    }
    
    var scoreO: Int {
        gameModel.scoreO
    }
    
    var winLine: [Square] {
        gameModel.winLine
    }
    
    var boardSize: Int {
        gameModel.boardSize
    }
    
    var board: [Square] {
        gameModel.board
    }
    
    var gameIsActive: Bool {
        gameModel.gameState == .moveX || gameModel.gameState == .moveO
    }
    
    func makeMove(index: Int) {
        gameModel.makeMove(index: index)
    }
    
    func newRound() {
        gameModel.newRound()
    }
    
    func resetScore() {
        gameModel.resetScore()
    }
}
