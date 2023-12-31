//
//  BreedListViewModel.swift
//  CatsApp
//
//  Created by Cecile on 08/09/2023.
//

import Foundation
import RealmSwift

final class BreedListViewModel: ObservableObject {

    @ObservedResults(
        Breed.self,
        sortDescriptor: SortDescriptor(keyPath: "name")
    ) var breeds

    @ObservedResults(
        Breed.self,
        where: { $0.isFiltered == true },
        sortDescriptor: SortDescriptor(keyPath: "name")
    ) var filteredBreeds

    @Published private var viewState: ViewState = .loading
    @Published var showError: Bool = false
    @Published var searchKey: String = ""

    private(set) var error: NetworkError?

    private var breedService: BreedService
    private var networkService: NetworkService
    private let limitOfBreedPerPage: Int = 10
    private var pageId: Int = 0
    private var endOfDataReached: Bool = false

    var isLoading: Bool {
        viewState == .loading
    }

    var isFetching: Bool {
        viewState == .fetching
    }

    init() {
        let httpClient = URLSessionClient(session: URLSession.shared, scheme: "https", baseUrl: Constants.apiBaseUrl)
        self.breedService = BreedService(remoteRepository: BreedRemoteRepository(httpClient: httpClient),
                                    localRepository: RealmLocalRepository())
        self.networkService = NetworkService.shared
    }

    init(breedService: BreedService, networkService: NetworkService) {
        self.breedService = breedService
        self.networkService = networkService
    }

    // MARK: Public Methods

    @MainActor
    func fetchNextBreeds() async {
        guard self.networkService.networkStatus == .satisfied else {
            print("❌ BreedListViewModel.fetchNextBreeds: no connection")
            return
        }
        guard self.endOfDataReached == false, !self.isFetching else {
            return
        }
        self.viewState = .fetching
        self.pageId += 1

        defer { self.viewState = .finished }

        await self.getBreeds()
    }

    @MainActor
    func fetchBreeds() async {
        guard self.networkService.networkStatus == .satisfied else {
            print("❌ BreedListViewModel.fetchBreeds: no connection")
            self.viewState = .finished
            return
        }
        await self.resetData()
        self.viewState = .loading

        defer { self.viewState = .finished }

        await self.getBreeds()
    }

    func hasReachedEnd(of breed: Breed) -> Bool {
        return filteredBreeds.last?.id == breed.id
    }

    // MARK: Private Methods

    private func resetData() async {
        self.endOfDataReached = false
        self.pageId = 0
        self.breedService.deleteBreeds(breeds: Array(breeds))
    }

    private func getBreeds() async {
        do {
            try await self.breedService.fetchBreeds(limitOfBreed: limitOfBreedPerPage,
                                                    pageId: pageId,
                                                    searchKey: searchKey)
        } catch {
            if let dataError = error as? DataError, dataError == .emptyData {
                self.endOfDataReached = true
            } else if let networkingError = error as? NetworkError {
                self.error = networkingError
                self.showError = true
            } else {
                let nsError = error as NSError

                if nsError.code == DomainError.notConnectedToInternet.rawValue {
                    self.error = .offlineError
                } else {
                    self.error = .custom(error)
                    self.showError = true

                }
            }
            print("❌ BreedListViewMobel.fetchBreeds error: \(error)")
        }
    }

}

// MARK: - ViewState Extension

extension BreedListViewModel {

    enum ViewState {
        case fetching
        case loading
        case finished
    }

}

// MARK: - Filtering Extension

extension BreedListViewModel {

    func filterBreeds() {
        self.breedService.filterBreeds(searchKey: searchKey)
    }

    func resetFilter() {
        self.searchKey.removeAll()
        self.filterBreeds()
    }

    func filterBreeds(breedName: String) {
        self.searchKey = breedName
        self.filterBreeds()
    }

}
