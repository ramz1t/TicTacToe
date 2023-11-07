//
//  GameView.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import SwiftUI
import UIKit
import AudioToolbox

struct GameView: View {
    @StateObject var gameViewModel = GameViewModel( gameState: .moveX)
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
            .onChange(of: gameViewModel.gameState) { state in
                switch state {
                case .winnerX, .winnerO:
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    break
                case .fullBoard:
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                    break
                default:
                    break
                }
            }
            
            authorLink
        }
    }
    
    var score: some View {
        HStack {
            SquareSymbolView(symbol: .cross)
            Text("\(gameViewModel.scoreX) - \(gameViewModel.scoreO)")
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
            ForEach(0 ..< gameViewModel.boardSize, id: \.self) { rowIndex in
                HStack {
                    ForEach(0 ..< gameViewModel.boardSize, id: \.self) { columnIndex in
                        let index = rowIndex * gameViewModel.boardSize + columnIndex
                        if index < gameViewModel.board.count {
                            SquareView(square: gameViewModel.board[index],
                                       index: index,
                                       gameViewModel: gameViewModel)
                        }
                    }
                }
            }
        }
    }
    
    var gameStatus: some View {
        HStack {
            switch gameViewModel.gameState {
            case .moveX:
                Text("Next Move Is")
                SquareSymbolView(symbol: .cross)
            case .moveO:
                Text("Next Move Is")
                SquareSymbolView(symbol: .circle)
            case .fullBoard:
                HStack {
                    SquareSymbolView(symbol: .cross)
                    Text("Draw")
                    SquareSymbolView(symbol: .circle)
                }
            case .winnerX:
                HStack {
                    Text("Game Over!")
                    SquareSymbolView(symbol: .cross)
                    Text("Won!")
                }
            case .winnerO:
                HStack {
                    Text("Game Over!")
                    SquareSymbolView(symbol: .circle)
                    Text("Won!")
                }
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
    GameView()
}
