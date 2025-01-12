//
//  MovieDetailsView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    @State var showSpokenLanguagesModal: Bool = false
    
    private var viewData: MovieDetailsViewData { viewModel.output.viewData }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack(alignment: .bottom, spacing: 16) {
                    BigPosterView(data: viewData.posterImage)
                    
                    Text(viewData.movieTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                }
                .frame(alignment: .bottom)
                
                if let overview = viewData.overview {
                    Text(overview)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if let releaseDate = viewData.releaseDate {
                    Text("\(Texts.MovieDetails.releaseDate): \(releaseDate)")
                }
                
                Button {
                    showSpokenLanguagesModal.toggle()
                } label: {
                    Text(Texts.MovieDetails.showSpokenLanguages)
                        .foregroundStyle(Colors.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(viewData.spokenLanguages == nil ? Colors.disabled : Colors.enabled)
                        }
                }
                .disabled(viewData.spokenLanguages == nil)
            }
            .padding(16)
        }
        .toolbar {
            FavoriteButton(data: viewData.favoriteButtonData)
        }
        .sheet(isPresented: $showSpokenLanguagesModal) {
            if let spokenLanguages = viewData.spokenLanguages {
                List {
                    ForEach(spokenLanguages, id: \.self) { text in
                        Text(text)
                    }
                }
            }
        }
    }
}
