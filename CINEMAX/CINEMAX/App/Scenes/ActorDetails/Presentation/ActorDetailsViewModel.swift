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
    @Published var isFavorited: Bool = false
    
    var viewAppeared: PassthroughSubject<Void, Never> = .init()
    var favoriteTapped: PassthroughSubject<Int, Never> = .init()
    var movieFavoriteTapped: PassthroughSubject<Void, Never> = .init()
    
    let actorID: Int
    var actorDetails: ActorDetails?
    var movieCast: Cast?
    var relatedMovies: [Cast] = []
    
    private let getActorDetailsUseCase: GetActorDetailsUseCaseProtocol
    private let getActorRelatedMoviesUseCase: GetActorRelatedMoviesUseCaseProtocol
    
    private let addToFavoritesUseCase: AddToFavoritesUseCaseProtocol
    private let isMovieFavorieUseCase: IsMovieFavorieUseCaseProtocol
    private let removeMovieCastFromFavoritesUseCase: RemoveMovieCastFromFavoritesUseCaseProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(actorID: Int, getActorDetailsUseCase: GetActorDetailsUseCaseProtocol = GetActorDetailsUseCase(),
         getActorRelatedMoviesUseCase: GetActorRelatedMoviesUseCaseProtocol = GetActorRelatedMoviesUseCase(),
         addToFavoritesUseCase: AddToFavoritesUseCaseProtocol = AddToFavoritesUseCase(),
         isMovieFavorieUseCase: IsMovieFavorieUseCaseProtocol = IsMovieFavorieUseCase(),
         removeMovieCastFromFavoritesUseCase: RemoveMovieCastFromFavoritesUseCaseProtocol = RemoveMovieCastFromFavoritesUseCase()) {
        self.actorID = actorID
        self.getActorDetailsUseCase = getActorDetailsUseCase
        self.getActorRelatedMoviesUseCase = getActorRelatedMoviesUseCase
        self.addToFavoritesUseCase = addToFavoritesUseCase
        self.isMovieFavorieUseCase = isMovieFavorieUseCase
        self.removeMovieCastFromFavoritesUseCase = removeMovieCastFromFavoritesUseCase
        
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
        
        favoriteTapped
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] index in
                guard let self = self else { return }
                
                relatedMovieFavoriteTapped(movieIndex: index)
            }
            .store(in: &cancellables)
    }
    
    private func relatedMovieFavoriteTapped(movieIndex: Int) {
        let movie = relatedMovies[movieIndex]
        guard let movieId = movie.id else {return }
        
        if isMovieFavorieUseCase.execute(movieId: movieId) {
            removeMovieCastFromFavoritesUseCase.execute(movieId: movieId)
        } else {
            addToFavoritesUseCase.execute(movieCast: movie)
        }
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

