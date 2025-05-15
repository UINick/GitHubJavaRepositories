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
    var pullRequestsListPublisher: Published<[PullRequestModel]>.Publisher { get }
    var pullRequestsCount: Int { get }
    var repoName: String { get }
}

class PullRequestViewModel {
    
    private var prInfo: PullRequestInfo
    private var repository: PullRequestRepositoryProtocol
    @Published private(set) var pullRequestsList: [PullRequestModel] = []
    
    init(prInfo: PullRequestInfo, repository: PullRequestRepositoryProtocol = PullRequestRepository()) {
        self.prInfo = prInfo
        self.repository = repository
    }
    
}

extension PullRequestViewModel: PullRequestBusinessLogic {
    
    var pullRequestsListPublisher: Published<[PullRequestModel]>.Publisher { $pullRequestsList }
    
    var repoName: String { prInfo.repository }
    
    var pullRequestsCount: Int { pullRequestsList.count }
    
    func pr(at index: Int) -> PullRequestModel {
        return pullRequestsList[index]
    }
    
    func fetchPullRequests() {
        Task {
            do {
                let info = (ownerLogin: prInfo.ownerLogin, repository: prInfo.repository)
                let prs = try await repository.fetchPullRequests(with: info)
                self.pullRequestsList = prs
            } catch {
                print("Erro ao buscar: \(error)")
            }
        }
    }
}
