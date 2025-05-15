//
//  JavaRepositoriesViewModelTest.swift
//  Java RepositoriesTests
//
//  Created by Nicholas Forte on 14/05/25.
//

import XCTest
@testable import Java_Repositories

class JavaRepositoriesViewModelTest: XCTestCase {
    
    var sut: JavaRepositoriesViewModel?
    var repository: GithubRepositorySpy?
    var imgRepository: ImageRepositorySpy?
    
    override func setUp() {
        super.setUp()
        setUpJavaRepositoriesViewModel()
    }
    
    override func tearDown() {
        sut = nil
        repository = nil
        imgRepository = nil
        super.tearDown()
    }
    
    func setUpJavaRepositoriesViewModel() {
        repository = GithubRepositorySpy()
        imgRepository = ImageRepositorySpy()
        sut = JavaRepositoriesViewModel(repository: repository!,
                                        imgRepository: imgRepository!)
    }
    
    
    func testFetchImage() {
        //Given
        let index = 0
        let imageURL = "https://example.com"
        
        //When
        sut?.fetchImage(for: index, imageURL: imageURL)
        
        //Then
        XCTAssertEqual(sut?.avatar.index, index)
        XCTAssertNil(sut?.avatar.image)
    }
    
    func testFetchReposotories() {
        //Given
        XCTAssertEqual(sut?.isLoading, false)
        
        //When
        sut?.fetchRepositories()
        
        //Then
        XCTAssertEqual(sut?.isLoading, true)
        XCTAssertEqual(sut?.repositories.count, repository?.mockRepositories.count)
    }
    
    func testRepositoryCount() {
        //Given
        let count = sut?.repositoryCount
        
        //When
        sut?.fetchRepositories()
        
        //Then
        XCTAssertEqual(count, sut?.repositories.count)
    }
}
