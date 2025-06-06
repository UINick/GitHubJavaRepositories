//
//  PullRequestRepository.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 11/05/25.
//

import Foundation

protocol PullRequestRepositoryProtocol {
    func fetchPullRequests(with info: PullRequestInfo) async throws -> [PullRequestModel]
}

class PullRequestRepository: PullRequestRepositoryProtocol {
    func fetchPullRequests(with info: PullRequestInfo) async throws -> [PullRequestModel] {
        guard let url = URL(string: "https://api.github.com/repos/\(info.ownerLogin)/\(info.repository)/pulls") else { return [] }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode([PullRequestModel].self, from: data)
        return decoded
    }
}
