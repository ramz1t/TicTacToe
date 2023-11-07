//
//  AboutView.swift
//  tictactoeWatchOS Watch App
//
//  Created by Timur Ramazanov on 07.11.2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text("Made by Ramz1 🇸🇪")
            Text("Github: @ramz1t")
                
        }
        .bold()
        .fontDesign(.rounded)
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
