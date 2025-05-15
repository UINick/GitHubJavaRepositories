//
//  GithubRepositorySpy.swift
//  Java RepositoriesTests
//
//  Created by Nicholas Forte on 14/05/25.
//

import Foundation
@testable import Java_Repositories

class GithubRepositorySpy: GitHubRepoRepositoryProtocol {
    var mockRepositories: [JavaProjectsModel] = []
    
    func getPopularJavaRepositories(_ page: Int) async throws -> [Java_Repositories.JavaProjectsModel] {
        mockRepositories = JavaProjectsModelMock.popularJavaRepositoriesResponse()
        return mockRepositories
    }
    
    
    
}
