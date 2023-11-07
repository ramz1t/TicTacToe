//
//  SquareModel.swift
//  tictactoe
//
//  Created by Timur Ramazanov on 06.11.2023.
//

import Foundation

public enum SquareSymbol: String {
    case cross = "xmark"
    case circle = "circle"
}

public struct Square: Hashable, Identifiable {
    public let id = UUID()
    public var symbol: SquareSymbol? = nil
    
    public init(symbol: SquareSymbol? = nil) {
        self.symbol = symbol
    }
}
