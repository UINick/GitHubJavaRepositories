//
//  PullRequestViewModel.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 11/05/25.
//

import Foundation

protocol PullRequestBusinessLogic {
    func fetchPullRequests()
    func pr(at index: Int) -> PullRequestModel
    func checkStatus()
    var pullRequestsListPublisher: Published<[PullRequestModel]>.Publisher { get }
    var pullRequestsCount: Int { get }
    var repoName: String { get }
    var isFavoriteRepo: Bool { get }
}

class PullRequestViewModel {
    
    let javaRepo: JavaProjectsModel
    private var prInfo: PullRequestInfo
    private var repository: PullRequestRepositoryProtocol
    @Published private(set) var pullRequestsList: [PullRequestModel] = []
    private let storage: ItemStorageProtocol
    
    init(prInfo: PullRequestInfo, 
         javaRepo: JavaProjectsModel,
         repository: PullRequestRepositoryProtocol = PullRequestRepository(),
         storage: ItemStorageProtocol = UserDefaultsStorage()) {
        self.prInfo = prInfo
        self.repository = repository
        self.storage = storage
        self.javaRepo = javaRepo
    }
    
}

extension PullRequestViewModel: PullRequestBusinessLogic {
    
    func checkStatus() {
        let items = storage.fetchItems()
        if !items.isEmpty && items.contains(where: { $0.id == javaRepo.id }) {
            removeFavorite()
        } else {
            addFavorite()
        }
    }
    
    var isFavoriteRepo: Bool {
        let items = storage.fetchItems()
        return items.contains(where: { $0.id == javaRepo.id })
    }
    
    func removeFavorite() {
        storage.removeItem(javaRepo)
    }
    
    func addFavorite() {
        var items = storage.fetchItems()
        guard !items.contains(where: { $0.id == javaRepo.id }) else { return }
        items.append(javaRepo)
        storage.saveItems(items)
    }
    
    var pullRequestsListPublisher: Published<[PullRequestModel]>.Publisher { $pullRequestsList }
    
    var repoName: String { prInfo.repository }
    
    var pullRequestsCount: Int { pullRequestsList.count }
    
    func pr(at index: Int) -> PullRequestModel {
        return pullRequestsList[index]
    }
    
    func fetchPullRequests() {
        Task {
            do {
                let prs = try await repository.fetchPullRequests(with: prInfo)
                self.pullRequestsList = prs
            } catch {
                print("Erro ao buscar: \(error)")
            }
        }
    }
}
