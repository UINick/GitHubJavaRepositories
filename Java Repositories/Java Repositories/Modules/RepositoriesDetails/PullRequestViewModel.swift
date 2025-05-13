//
//  PullRequestViewModel.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 11/05/25.
//

import Foundation

protocol PullRequestBusinessLogic {
    var repoDetails: PullRequestModel { get set }
}

class PullRequestViewModel: PullRequestBusinessLogic {
    var repoDetails: PullRequestModel
    
    init(repoDetails: PullRequestModel) {
        self.repoDetails = repoDetails
    }
}
