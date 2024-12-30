//
//  ActorListView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 09/12/2024.
//

import SwiftUI

struct ActorListView: View {
    @ObservedObject var viewModel: ActorListViewModel
    @EnvironmentObject var router: Router

    init(viewModel: ActorListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            NavigationBarView(
                title: "Popular Actors",
                onDismiss: {
                    router.navigateBack()
                }
            )
            .tint(.white)
            .cornerRadius(8)

            switch viewModel.state {
            case .loading:
                makeLoadingView()

            case .empty:
                makeEmptyView()

            case .failed:
                makeFailureView()

            case .loaded:
                makeActorListView()
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color.darkAccent)
        .onAppear {
            viewModel.viewAppeared.send()
        }
        .navigationBarHidden(true)
    }

    private func makeLoadingView() -> some View {
        ProgressView()
            .tint(.white)
    }

    private func makeEmptyView() -> some View {
        Text("No Data Available")
            .foregroundColor(.gray)
            .padding()
    }

    private func makeFailureView() -> some View {
        VStack {
            Text("Something went wrong, Try again later!")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
    }

    private func makeActorListView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.movieCast) { movieCast in
                    Button(action: {
                        if let actorID = movieCast.id {
                            router.navigate(to: .actorDetails(actorID: actorID))
                        }
                    }) {
                        ActorCardView(actor: movieCast)
                    }
                }
            }
        }
    }
}

#Preview {
    ActorListView(viewModel: ActorListViewModel())
}
