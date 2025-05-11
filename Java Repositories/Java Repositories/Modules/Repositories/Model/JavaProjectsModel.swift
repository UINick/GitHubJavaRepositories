//
//  JavaProjectsModel.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 08/05/25.
//

import Foundation

struct JavaProjectsModel: Decodable {
    let repositoryName: String
    let repositoryDescripton : String
    let forksCount: Int
    let starsCount: Int
    let owner: OwnerProjectModel
    
    enum CodingKeys: String, CodingKey {
        case repositoryName = "name"
        case repositoryDescripton = "description"
        case forksCount = "forks_count"
        case starsCount = "stargazers_count"
        case owner
    }
}

struct OwnerProjectModel: Decodable {
    let avatarUrl: String
    let login: String
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarUrl = "avatar_url"
    }
}

struct SearchResponse: Decodable {
    let items: [JavaProjectsModel]
}
