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
            
            VStack {
                ForEach(gameViewModel.board.squares, id:\.self) { row in
                    HStack {
                        ForEach(row) { square in
                            SquareView(square: square, boardViewModel: gameViewModel)
                        }
                    }
                }
            }
            
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
            
            Button("Start New Game") {
                gameViewModel.initGame()
            }
        }
        .onAppear {
            gameViewModel.initGame()
        }
        .bold()
    }
}

#Preview {
    ContentView()
}
