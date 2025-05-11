//
//  GithubRepository.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 08/05/25.
//

import Foundation

protocol GitHubRepoRepositoryProtocol {
    func getPopularJavaRepositories(_ page: Int) async throws -> [JavaProjectsModel]
}

class GitHubRepoRepository: GitHubRepoRepositoryProtocol {
    func getPopularJavaRepositories(_ page: Int) async throws -> [JavaProjectsModel] {
        let url = URL(string: "https://api.github.com/search/repositories?q=language:Java&sort=stars&%20page=\(page)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(SearchResponse.self, from: data)
        return decoded.items
    }
}
