//
//  JavaRepositoryViewModelSpy.swift
//  Java RepositoriesTests
//
//  Created by Nicholas Forte on 14/05/25.
//

import Foundation
import UIKit
@testable import Java_Repositories

class JavaRepositoryViewModelSpy: JavaRepositoriesBusinessLogic {
    
    @Published private(set) var repositories: [JavaProjectsModel] = []
    @Published var isLoading: Bool = false
    @Published var avatar: AvatarInfo = (index: 0, image: nil)
    private var currentPage = 1
    
    func fetchRepositories() {
        isLoading = true
        repositories = JavaProjectsModelMock.popularJavaRepositoriesResponse()
    }
    
    func getRepoInfo(_ project: Java_Repositories.JavaProjectsModel) -> Java_Repositories.PullRequestInfo {
        let repo = repositories[0]
        return (ownerLogin: repo.owner.login, repository: repo.repositoryName)
    }
    
    func repository(at index: Int) -> Java_Repositories.JavaProjectsModel {
        let repo = repositories[index]
        return JavaProjectsModel(repositoryName: repo.repositoryName,
                                 repositoryDescripton: repo.repositoryDescripton,
                                 forksCount: repo.forksCount,
                                 starsCount: repo.starsCount,
                                 owner: repo.owner)
    }
    
    func fetchImage(for index: Int, imageURL: String) {
        
    }
    
    var repositoryCount: Int {
        repositories.count
    }
    
    var repositoriesPublisher: Published<[Java_Repositories.JavaProjectsModel]>.Publisher {
        $repositories
    }
    
    var isLoadingPublisher: Published<Bool>.Publisher {
        $isLoading
    }
    
    var imagePublisher: Published<Java_Repositories.AvatarInfo>.Publisher {
        $avatar
    }
    
    
}


