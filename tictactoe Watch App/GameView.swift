//
//  ContentView.swift
//  tictactoeWatchOS Watch App
//
//  Created by Timur Ramazanov on 06.11.2023.
//

import SwiftUI
import WatchKit

struct ContentView: View {
    @ObservedObject var gameViewModel = GameViewModel()
    @State private var isOpen = false
    
    var body: some View {
        NavigationStack {
            VStack {
                board
            }
            .navigationTitle("Tic Tac Toe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                toolbar
            }
            .confirmationDialog("Choose option", isPresented: $isOpen) {
                resetOptionsSheet
            }
            .onAppear {
                gameViewModel.newRound()
            }
            .fontDesign(.rounded)
            .onChange(of: gameViewModel.gameState) { state in
                switch state {
                case .winnerX, .winnerO:
                    WKInterfaceDevice().play(WKHapticType.success)
                    break
                case .fullBoard:
                    WKInterfaceDevice().play(WKHapticType.retry)
                    break
                default:
                    break
                }
            }
        }
    }
    
    var board: some View {
        VStack {
            ForEach(0 ..< gameViewModel.boardSize, id: \.self) { rowIndex in
                HStack {
                    ForEach(0 ..< gameViewModel.boardSize, id: \.self) { columnIndex in
                        let index = rowIndex * gameViewModel.boardSize + columnIndex
                        if index < gameViewModel.board.count {
                            SquareView(square: gameViewModel.board[index],
                                       index: index,
                                       gameViewModel: gameViewModel)
                        }
                    }
                }
            }
        }
    }
    
    var toolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    isOpen = true
                } label: {
                    Label("Reset", systemImage: "arrow.clockwise")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AboutView()
                } label: {
                    Label("Info", systemImage: "info")
                        .foregroundStyle(.white)
                }
            }
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    gameStatus
                    Spacer()
                    HStack {
                        SquareSymbolView(symbol: .cross)
                        Text("\(gameViewModel.scoreX):\(gameViewModel.scoreO)")
                        SquareSymbolView(symbol: .circle)
                    }
                    .transaction { t in
                        t.animation = .none
                    }
                }
            }
        }
    }
    
    var gameStatus: some View {
        HStack {
            switch gameViewModel.gameState {
            case .moveX:
                SquareSymbolView(symbol: .cross)
                    .frame(minWidth: 22)
                Text("Next")
            case .moveO:
                SquareSymbolView(symbol: .circle)
                    .frame(minWidth: 22)
                Text("Next")
            case .fullBoard:
                HStack {
                    SquareSymbolView(symbol: .cross)
                    Text("Draw")
                    SquareSymbolView(symbol: .circle)
                }
            case .winnerX:
                HStack {
                    SquareSymbolView(symbol: .cross)
                        .frame(minWidth: 22)
                    Text("Won!")
                }
            case .winnerO:
                HStack {
                    SquareSymbolView(symbol: .circle)
                        .frame(minWidth: 22)
                    Text("Won!")
                }
            }
        }
    }
    
    @ViewBuilder var resetOptionsSheet: some View {
        Button("Reset score") {
            withAnimation {
                gameViewModel.resetScore()
            }
        }
        Button("New round") {
            withAnimation {
                gameViewModel.newRound()
            }
        }
    }
}

#Preview {
    ContentView()
}
