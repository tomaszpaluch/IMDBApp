//
//  RouterView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()

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
    enum Route: Hashable {
        case movieDetails(MovieDetailsViewData)
    }
    
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case let .movieDetails(data):
            MovieDetailsView(
                viewModel: .init(
                    apiService: MovieDetailsApiService(),
                    initialData: data
                )
            )
        }
    }
    
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
