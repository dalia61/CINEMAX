//
//  ActorListViewModel.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 16/12/2024.
//

import Foundation
import Combine

class ActorListViewModel: ObservableObject {
    @Published var state: ViewState = .loading

    var viewAppeared: PassthroughSubject<Void, Never> = .init()

    var movieCast: [MovieCast] = []

    private let getActorsListUseCase: GetActorsListUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    init(
        getActorsListUseCase: GetActorsListUseCaseProtocol = GetActorsListUseCase()
    ) {
        self.getActorsListUseCase = getActorsListUseCase
        setupObservers()
    }
    
    func setupObservers() {
        viewAppeared
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                getActorsList()
            }
            .store(in: &cancellables)
    }
    
    private func getActorsList() {
        state = .loading

        getActorsListUseCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        state = .failed
                    }
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    movieCast = mapActorResponse(response: response)
                    state = movieCast.isEmpty ? .empty : .loaded
                }
            })
            .store(in: &cancellables)
    }
    
    private func mapActorResponse(response: ActorsListResponse) -> [MovieCast] {
        return response.results ?? []
    }
}
