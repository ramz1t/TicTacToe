//
//  SquareView.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import SwiftUI

struct SquareView: View {
    let square: Square
    let gameViewModel: GameViewModel
    var active: Bool {
        !(gameViewModel.isOver || gameViewModel.boardIsFull)
    }
    var isWinningPosition: Bool {
        gameViewModel.winLine.contains(square) && gameViewModel.winner != nil
    }
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            if square.symbol != nil {
                SquareSymbolView(symbol: square.symbol)
                    .font(.system(size: 50))
                    .padding()
                    .opacity(!(active || isWinningPosition) ? 0.2 : 1)
            } else {
                Rectangle()
                    .foregroundColor(colorScheme == .light ? .white : .black.opacity(0.001))
            }
        }
        .frame(width: 80, height: 80)
        .border(Color.primary.opacity(!active && isWinningPosition ? 1 : active ? 0.5 : 0.1), width: 2)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.075)) {
                gameViewModel.makeMove(square: square)
            }
        }
    }
}

#Preview {
    SquareView(square: Square(i: 0, symbol: .cross), gameViewModel: GameViewModel())
}
