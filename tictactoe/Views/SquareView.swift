//
//  SquareView.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import SwiftUI

struct SquareView: View {
    let square: Square
    let boardViewModel: GameViewModel
    
    var body: some View {
        Image(systemName: square.symbol.rawValue)
            .resizable()
            .frame(width: 50, height: 50)
            .foregroundColor(square.symbol == .cross ? .red : .blue)
            .padding()
            .border(Color.primary, width: 2)
            .onTapGesture {
                boardViewModel.makeMove(square: square)
            }
    }
}

#Preview {
    SquareView(square: Square(x: 0, y: 0, symbol: .cross), boardViewModel: GameViewModel())
}
