//
//  ContentView.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import SwiftUI

struct ContentView: View {
    var gameViewModel = GameViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Tic Tac Toe")
                    .font(.largeTitle)
                
                score
                board
                gameStatus
                
                Button("Start New Round") {
                    withAnimation {
                        gameViewModel.newRound()
                    }
                }
                .buttonStyle(.bordered)
            }
            .onAppear {
                gameViewModel.newRound()
            }
            .bold()
            .fontDesign(.rounded)
            .padding(30)
            .background(colorScheme == .light ? .white : .white.opacity(0.2))
            .cornerRadius(20)
            .shadow(radius: 25)
            
            authorLink
        }
    }
    
    var score: some View {
        HStack {
            SquareSymbolView(symbol: .cross)
            Text("\(gameViewModel.score[.cross, default: 0]) - \(gameViewModel.score[.circle, default: 0])")
            SquareSymbolView(symbol: .circle)
            Button("Reset") {
                withAnimation {
                    gameViewModel.resetScore()
                }
            }
            .buttonStyle(.bordered)
            .padding(.leading, 5)
            .font(.footnote)
            .foregroundColor(.secondary)
        }
    }
    
    var board: some View {
        VStack {
            ForEach(0 ..< gameViewModel.board.squares.count / 3, id: \.self) { rowIndex in
                HStack {
                    ForEach(0 ..< 3, id: \.self) { columnIndex in
                        let index = rowIndex * 3 + columnIndex
                        if index < gameViewModel.board.squares.count {
                            SquareView(square: gameViewModel.board.squares[index], gameViewModel: gameViewModel)
                        }
                    }
                }
            }
        }
    }
    
    var gameStatus: some View {
        HStack {
            if gameViewModel.isOver {
                HStack {
                    Text("Game Over!")
                    SquareSymbolView(symbol: gameViewModel.winner)
                    Text("Won!")
                }
            } else if gameViewModel.boardIsFull {
                HStack {
                    SquareSymbolView(symbol: .cross)
                    Text("Draw")
                    SquareSymbolView(symbol: .circle)
                }
            } else {
                Text("Next Move Is")
                SquareSymbolView(symbol: gameViewModel.isX ? .cross : .circle)
            }
        }
    }
    
    var authorLink: some View {
        Link(destination: URL(string: "https://github.com/ramz1t/tictactoe")!, label: {
            HStack(spacing: 5) {
                Text("Made by Ramz1 🇸🇪")
                Image(systemName: "arrow.up.forward.app")
            }
            .bold()
            .foregroundStyle(.secondary)
            .fontDesign(.rounded)
        })
        .bold()
        .foregroundStyle(.secondary)
        .fontDesign(.rounded)
    }
}

#Preview {
    ContentView()
}
