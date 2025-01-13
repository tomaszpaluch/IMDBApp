//
//  RouterView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    // Our root view content
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Router.Route.self) { route in
                    router.view(for: route)
                }
        }
        .environmentObject(router)
    }
}

class Router: ObservableObject {
    // Contains the possible destinations in our Router
    enum Route: Hashable {
        case popularMovies
        case movieDetails(MovieDetailsViewData)
    }
    
    // Used to programatically control our navigation stack
    @Published var path: NavigationPath = NavigationPath()
    
    // Builds the views
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .popularMovies:
            PopularMoviesView(
                viewModel: .init(
                    logic: PopularMoviesLogic(
                        popularMoviesPaginationFactory: PopularMoviesPaginationFactory<
                        PopularMoviesPagination,
                        SearchAPIService,
                        DiscoverAPIService>(),
                        popularMoviesPersistence: PopularMoviesPersistence()
                    )
                )
            )
        case let .movieDetails(data):
            MovieDetailsView(
                viewModel: .init(
                    apiService: MovieDetailsApiService(),
                    initialData: data
                )
            )
        }
    }
    
    // Used by views to navigate to another view
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    // Used to go back to the previous screen
    func navigateBack() {
        path.removeLast()
    }
    
    // Pop to the root screen in our hierarchy
    func popToRoot() {
        path.removeLast(path.count)
    }
}

