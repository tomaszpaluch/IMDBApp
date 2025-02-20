//
//  ContentView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RouterView {
            PopularMoviesView(
                viewModel: .init(
                    logic: PopularMoviesLogicFactory.make()
                )
            )
        }
    }
}

#Preview {
    ContentView()
}

