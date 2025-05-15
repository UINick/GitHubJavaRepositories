//
//  JavaProjectsModelMock.swift
//  Java RepositoriesTests
//
//  Created by Nicholas Forte on 14/05/25.
//

@testable import Java_Repositories
import Foundation

struct JavaProjectsModelMock {
    static func popularJavaRepositoriesResponse() -> [JavaProjectsModel] {
        return [
            JavaProjectsModel(repositoryName: "Projeto 1", repositoryDescripton: "Projeto 1", forksCount: 0, starsCount: 0, owner: OwnerProjectModel(avatarUrl: "", login: "")),
            JavaProjectsModel(repositoryName: "Projeto 1", repositoryDescripton: "Projeto 1", forksCount: 0, starsCount: 0, owner: OwnerProjectModel(avatarUrl: "", login: "")),
            JavaProjectsModel(repositoryName: "Projeto 1", repositoryDescripton: "Projeto 1", forksCount: 0, starsCount: 0, owner: OwnerProjectModel(avatarUrl: "", login: ""))
        ]
    }
}
