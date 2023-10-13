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
        VStack {
            if let image = square.symbol?.rawValue {
                Image(systemName: image)
                    .resizable()
                    .padding()
            } else {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.025)
            }
        }
        .frame(width: 80, height: 80)
        .foregroundColor(square.symbol == .cross ? .red : .blue)
        .border(Color.primary.opacity(0.5), width: 2)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.075)) {
                boardViewModel.makeMove(square: square)
            }
        }
        
    }
}

#Preview {
    SquareView(square: Square(i: 0, symbol: .cross), boardViewModel: GameViewModel())
}
