//
//  ActorDetailsViewModel.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 16/12/2024.
//

import Foundation
import Combine

class ActorDetailsViewModel: ObservableObject {
    @Published var detailsState: ViewState = .loading
    @Published var relatedMoviesState: ViewState = .loading
    
    var viewAppeared: PassthroughSubject<Void, Never> = .init()
    
    let actorID: Int
    var actorDetails: ActorDetails?
    var relatedMovies: [Cast] = []

    private let getActorDetailsUseCase: GetActorDetailsUseCaseProtocol
    private let getActorRelatedMoviesUseCase: GetActorRelatedMoviesUseCaseProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(actorID: Int, getActorDetailsUseCase: GetActorDetailsUseCaseProtocol = GetActorDetailsUseCase(),
         getActorRelatedMoviesUseCase: GetActorRelatedMoviesUseCaseProtocol = GetActorRelatedMoviesUseCase()) {
        self.actorID = actorID
        self.getActorDetailsUseCase = getActorDetailsUseCase
        self.getActorRelatedMoviesUseCase = getActorRelatedMoviesUseCase
        
        setupObservers()
    }

    func setupObservers() {
        viewAppeared.subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                getActorDetails()
                getActorRelatedMovies()
            }
            .store(in: &cancellables)
    }

    private func getActorDetails() {
        detailsState = .loading

        getActorDetailsUseCase.execute(actorId: actorID)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        detailsState = .failed
                    }
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    actorDetails = response
                    detailsState = .loaded
                }
            })
            .store(in: &cancellables)
    }

    private func getActorRelatedMovies() {
        relatedMoviesState = .loading

        getActorRelatedMoviesUseCase.execute(actorId: actorID)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        relatedMoviesState = .failed
                    }
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    relatedMovies = mapActorResponse(response: response)
                    relatedMoviesState = .loaded
                }
            })
            .store(in: &cancellables)
    }
    private func mapActorResponse(response: ActorRelatedMoviesResponse) -> [Cast] {
        return response.cast ?? []
    }
}

