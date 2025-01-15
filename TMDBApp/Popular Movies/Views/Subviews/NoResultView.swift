//
//  NoResultView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 15/01/2025.
//

import SwiftUI

struct NoResultView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text(":(")
                .font(.system(size: 72))
            Text("No result found")
        }
    }
}
