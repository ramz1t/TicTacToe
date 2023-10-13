//
//  ContentView.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import SwiftUI

struct ContentView: View {
    var gameViewModel = GameViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Tic Tac Toe")
                .font(.largeTitle)
            
            board
            gameStatus
            
            Button("Start New Game") {
                withAnimation {
                    gameViewModel.initGame()
                }
            }
        }
        .onAppear {
            gameViewModel.initGame()
        }
        .bold()
    }
    
    var board: some View {
        VStack {
            ForEach(0 ..< gameViewModel.board.squares.count / 3, id: \.self) { rowIndex in
                HStack {
                    ForEach(0 ..< 3, id: \.self) { columnIndex in
                        let index = rowIndex * 3 + columnIndex
                        if index < gameViewModel.board.squares.count {
                            SquareView(square: gameViewModel.board.squares[index], boardViewModel: gameViewModel)
                        }
                    }
                }
            }
        }
    }
    
    var gameStatus: some View {
        HStack {
            if gameViewModel.isOver {
                Text("Game Over!")
            } else if gameViewModel.boardIsFull {
                Text("No more moves, please restart")
            } else {
                Text("Next move is")
                Image(systemName: gameViewModel.isX ? "xmark" : "circle")
                    .foregroundColor(gameViewModel.isX ? .red : .blue)
            }
        }
    }
}

#Preview {
    ContentView()
}
