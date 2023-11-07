//
//  SquareView.swift
//  tictactoeWatchOS Watch App
//
//  Created by Timur Ramazanov on 06.11.2023.
//

import SwiftUI
import WatchKit

struct SquareView: View {
    var square: Square
    let index: Int
    @ObservedObject var gameViewModel: GameViewModel
    var isWinningPosition: Bool {
        gameViewModel.winLine.contains(square)
    }
    var squareSize: CGFloat {
        return WKInterfaceDevice.current().screenBounds.width / 5
    }
    
    var body: some View {
        VStack {
            if square.symbol != nil {
                SquareSymbolView(symbol: square.symbol)
                    .font(.system(.title3))
                    .padding()
                    .onTapGesture {
                        gameViewModel.makeMove(index: index)
                    }
            } else {
                Rectangle()
                    .foregroundColor(.black.opacity(0.001))
            }
        }
        .frame(minWidth: squareSize, maxWidth: squareSize, minHeight: squareSize, maxHeight: squareSize)
        .border(Color.primary.opacity(!gameViewModel.gameIsActive && isWinningPosition ? 1 : gameViewModel.gameIsActive ? 0.5 : 0.1), width: 2)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.075)) {
                gameViewModel.makeMove(index: index)
            }
        }
        .disabled([GameState.winnerO,
                   GameState.winnerX,
                   GameState.fullBoard].contains(gameViewModel.gameState))
    }
}

#Preview {
    NavigationStack {
        HStack {
            ForEach(0..<3) { _ in
                VStack {
                    SquareView(square: Square(symbol: .cross), index: 1, gameViewModel: GameViewModel())
                    SquareView(square: Square(symbol: nil), index: 2, gameViewModel: GameViewModel())
                    SquareView(square: Square(symbol: nil), index: 3, gameViewModel: GameViewModel())
                }
            }
        }
        
        .navigationTitle("Tic Tac Toe")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Text("Status")
                    Spacer()
                    HStack {
                        SquareSymbolView(symbol: .cross)
                        Text("1:2")
                        SquareSymbolView(symbol: .circle)
                    }
                }
                
            }
        }
    }
}
