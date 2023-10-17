//
//  SquareSymbolView.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 14.10.2023.
//

import SwiftUI

struct SquareSymbolView: View {
    let symbol: SquareSymbol?
    
    var body: some View {
        if let symbol {
            Image(systemName: symbol.rawValue)
                .foregroundColor(symbol == .cross ? .red : .blue)
        }
    }
}

#Preview {
    HStack {
        SquareSymbolView(symbol: .cross)
        SquareSymbolView(symbol: .circle)
    }
}
