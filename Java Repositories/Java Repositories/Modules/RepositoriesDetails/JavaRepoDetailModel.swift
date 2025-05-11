//
//  JavaRepoDetailModel.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 11/05/25.
//

import Foundation

struct JavaRepoDetailModel {
    let repoName: String
    let open: Int
    let close: Int
    let pullRequestTitle: String
    let pullRequestSubtitle: String
    let owner: OwnerProjectModel
}
