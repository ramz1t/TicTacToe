//
//  SquareModel.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 17.09.2023.
//

import Foundation

enum SquareSymbol: String {
    case empty = ""
    case cross = "xmark"
    case circle = "circle"
}

struct Square: Hashable, Identifiable {
    let id = UUID()
    let x: Int
    let y: Int
    var symbol: SquareSymbol = .empty
}
