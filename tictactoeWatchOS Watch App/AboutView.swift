//
//  AboutView.swift
//  tictactoeWatchOS Watch App
//
//  Created by Timur Ramazanov on 07.11.2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 25) {
            Spacer()
            Image(systemName: "swift")
                .font(.title)
            Text("Made with ❤️ in 🇸🇪")
            Text("Github: @ramz1t")
                .bold()
        }
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
