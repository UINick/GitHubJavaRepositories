//
//  JavaRepoDetailViewModel.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 11/05/25.
//

import Foundation

protocol JavaRepoDetailBussinessLogic {
    var repoDetails: JavaRepoDetailModel { get set }
}

class JavaRepoDetailViewModel: JavaRepoDetailBussinessLogic {
    var repoDetails: JavaRepoDetailModel
    
    init(repoDetails: JavaRepoDetailModel) {
        self.repoDetails = repoDetails
    }
}
