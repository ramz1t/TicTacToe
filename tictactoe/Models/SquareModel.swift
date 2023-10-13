//
//  SquareModel.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import Foundation

enum SquareSymbol: String {
    case cross = "xmark"
    case circle = "circle"
}

struct Square: Hashable, Identifiable {
    let id = UUID()
    let i: Int
    var symbol: SquareSymbol? = nil
}
