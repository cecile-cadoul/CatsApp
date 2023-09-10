//
//  BreedDetailsViewModel.swift
//  CatsApp
//
//  Created by Cecile on 10/09/2023.
//

import Foundation
import RealmSwift

class BreedDetailsViewModel: ObservableObject {

    var breed: Breed

    @Published private var viewState: ViewState = .loading
    @Published var showError: Bool = false

    private(set) var error: NetworkError?

    private var imageService: ImageService
    private var networkService: NetworkService
    private let limitOfBreedPerPage: Int = 5
    private var pageId: Int = 0
    private var endOfDataReached: Bool = false

    var isLoading: Bool {
        viewState == .loading
    }

    var isFetching: Bool {
        viewState == .fetching
    }

    init(breed: Breed) {
        let httpClient = URLSessionClient(session: URLSession.shared, scheme: "https", baseUrl: Constants.apiBaseUrl)
        self.imageService = ImageService(remoteRepository: ImageRemoteRepository(httpClient: httpClient),
                                         localRepository: RealmLocalRepository())
        self.networkService = NetworkService.shared
        self.breed = breed
    }

    init(breed: Breed, imageService: ImageService, networkService: NetworkService) {
        self.imageService = imageService
        self.networkService = networkService
        self.breed = breed
    }

    // MARK: Public Methods

    @MainActor
    func fetchNextImages() async {
        guard self.networkService.networkStatus == .satisfied else {
            print("❌ BreedDetailsViewModel.fetchNextImages: no connection")
            return
        }
        guard self.endOfDataReached == false, !self.isFetching else {
            return
        }
        self.viewState = .fetching
        self.pageId += 1

        defer { self.viewState = .finished }

        await self.getImages()
    }

    @MainActor
    func fetchImages() async {
        guard self.networkService.networkStatus == .satisfied else {
            print("❌ BreedDetailsViewModel.fetchImages: no connection")
            self.viewState = .finished
            return
        }
        self.resetData()
        self.viewState = .loading

        defer { self.viewState = .finished }

        await self.getImages()
    }

    func hasReachedEnd(of image: BreedImage) -> Bool {
        return breed.images.last?.id == image.id
    }

    // MARK: Private Methods

    @MainActor
    private func resetData() {
        self.endOfDataReached = false
        self.pageId = 0
        self.imageService.deleteBreedImages(to: breed)
    }

    @MainActor
    private func getImages() async {
        do {
            try await self.imageService.fetchBreedImages(breed: self.breed,
                                                         limitOfImage: limitOfBreedPerPage,
                                                         pageId: self.pageId, includeBreeds: false,
                                                         imageSize: BreedImage.Size.med.rawValue)
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
            print("❌ BreedDetailsViewModel.getImages error: \(error)")
        }
    }

}

// MARK: - Extension

extension BreedDetailsViewModel {

    enum ViewState {
        case fetching
        case loading
        case finished
    }

}
