//
//  SquareView.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import SwiftUI

struct SquareView: View {
    let square: Square
    let index: Int
    @StateObject var gameViewModel: GameViewModel

    var isWinningPosition: Bool {
        gameViewModel.winLine.contains(square)
    }
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            if square.symbol != nil {
                SquareSymbolView(symbol: square.symbol)
                    .font(.system(size: 50))
                    .padding()
                    .opacity(!(gameViewModel.gameIsActive || isWinningPosition) ? 0.2 : 1)
            } else {
                Rectangle()
                    .foregroundColor(colorScheme == .light ? .white : .black.opacity(0.001))
            }
        }
        .frame(width: 80, height: 80)
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
    SquareView(square: Square(symbol: .cross),
               index: 1,
               gameViewModel: GameViewModel())
}
