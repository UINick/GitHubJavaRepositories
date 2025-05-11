//
//  JavaRepositoriesViewModel.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 08/05/25.
//

import Foundation
import Combine

protocol JavaRepositoriesBusinessLogic {
    func fetchRepositories()
    func getRepoInfo(_ project : JavaProjectsModel) -> JavaRepoDetailModel
    func repository(at index: Int) -> JavaProjectsModel
    
    var repositoryCount: Int { get }
    var repositoriesPublisher: Published<[JavaProjectsModel]>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
}


class JavaRepositoriesViewModel: JavaRepositoriesBusinessLogic {
        
    @Published private(set) var repositories: [JavaProjectsModel] = []
    @Published var isLoading: Bool = false
    
    private var repository: GitHubRepoRepositoryProtocol
    private var currentPage = 1
    
    var repositoriesPublisher: Published<[JavaProjectsModel]>.Publisher { $repositories }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    init(repository: GitHubRepoRepositoryProtocol = GitHubRepoRepository()) {
        self.repository = repository
    }

    func fetchRepositories() {
        guard !isLoading else { return }
        isLoading = true

        Task {
            do {
                let newRepos = try await repository.getPopularJavaRepositories(currentPage)
                currentPage += 1
                self.repositories.append(contentsOf: newRepos)
                self.isLoading = false
                
            } catch {
                self.isLoading = false
            }
        }
    }
    
    func getRepoInfo(_ project : JavaProjectsModel) -> JavaRepoDetailModel {
        return JavaRepoDetailModel(repoName: project.repositoryName,
                                   open: 2,
                                   close: 3,
                                   pullRequestTitle: project.repositoryDescripton,
                                   pullRequestSubtitle: project.repositoryDescripton,
                                   owner: OwnerProjectModel(avatarUrl: "http", login: "uhu"))
    }
    
    func repository(at index: Int) -> JavaProjectsModel {
        return repositories[index]
    }
    
    var repositoryCount: Int {
        return repositories.count
    }
}
