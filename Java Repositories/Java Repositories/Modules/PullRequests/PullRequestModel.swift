//
//  PullRequestModel.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 11/05/25.
//

import Foundation

struct PullRequestModel: Decodable {
    let prTitle: String?
    let prDate: String?
    let prBody: String?
    let user: PullRequestUserModel
    
    enum CodingKeys: String, CodingKey {
        case prTitle = "title"
        case prDate = "created_at"
        case prBody = "body"
        case user = "user"
    }
}

struct PullRequestUserModel: Decodable {
    let prOwnerName: String
    
    enum CodingKeys: String, CodingKey {
        case prOwnerName = "login"
    }
}

public typealias PullRequestInfo = (ownerLogin: String, repository: String)
