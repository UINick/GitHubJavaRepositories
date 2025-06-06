//
//  JavaRepositoriesViewModel.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 08/05/25.
//

import Foundation
import Combine
import UIKit

protocol JavaRepositoriesBusinessLogic {
    func fetchRepositories()
    func fetchFavoritesRepositories()
    func getRepoInfo(_ project : JavaProjectsModel) -> PullRequestInfo
    func repository(at index: Int) -> JavaProjectsModel
    func fetchImage(for index: Int, imageURL: String)
    
    var repositoryCount: Int { get }
    var repositoriesPublisher: Published<[JavaProjectsModel]>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    var imagePublisher: Published<AvatarInfo>.Publisher { get }
}


class JavaRepositoriesViewModel {
        
    @Published private(set) var repositories: [JavaProjectsModel] = []
    @Published var isLoading: Bool = false
    @Published var avatar: AvatarInfo = (index: 0, image: nil)
    
    private var repository: GitHubRepoRepositoryProtocol
    private var imageRepository: ImageRepositoryProtocol
    private let storage: ItemStorageProtocol
    private var currentPage = 1
    
    init(repository: GitHubRepoRepositoryProtocol = GitHubRepoRepository(),
         imgRepository: ImageRepositoryProtocol = ImageRepository(),
         storage: ItemStorageProtocol = UserDefaultsStorage()) {
        self.repository = repository
        self.imageRepository = imgRepository
        self.storage = storage
    }
    
}

extension JavaRepositoriesViewModel: JavaRepositoriesBusinessLogic {
    
    var repositoriesPublisher: Published<[JavaProjectsModel]>.Publisher { $repositories }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    var imagePublisher: Published<AvatarInfo>.Publisher { $avatar }
    
    func repository(at index: Int) -> JavaProjectsModel {
        return repositories[index]
    }
    
    var repositoryCount: Int {
        return repositories.count
    }
    
    func fetchFavoritesRepositories() {
        repositories = storage.fetchItems()
    }
    
    func fetchRepositories() {
        guard !isLoading else { return }
        isLoading = true

        Task {
            defer { isLoading = false }
            do {
                let newRepos = try await repository.getPopularJavaRepositories(currentPage)
                if !newRepos.isEmpty {
                    currentPage += 1
                    repositories.append(contentsOf: newRepos)
                }
            } catch {
                print("Erro ao buscar: \(error)")
            }
        }
    }
    
    func getRepoInfo(_ project : JavaProjectsModel) -> PullRequestInfo {
        return (ownerLogin: project.owner.login,
                repository: project.repositoryName)
    }
    
    func fetchImage(for index: Int, imageURL: String) {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.imageRepository.loadImage(from: imageURL) { image in
                DispatchQueue.main.async {
                    self?.avatar = (index, image)
                }
            }
        }
    }
}
