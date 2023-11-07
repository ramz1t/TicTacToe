//
//  SquareSymbolView.swift
//  tictactoeWatchOS Watch App
//
//  Created by Timur Ramazanov on 06.11.2023.
//
import SwiftUI

struct SquareSymbolView: View {
    let symbol: SquareSymbol?
    
    var body: some View {
        if let symbol {
            Image(systemName: symbol.rawValue)
                .foregroundColor(symbol == .cross ? .red : .blue)
                .bold()
        }
    }
}

#Preview {
    HStack {
        SquareSymbolView(symbol: .cross)
        SquareSymbolView(symbol: .circle)
    }
}
