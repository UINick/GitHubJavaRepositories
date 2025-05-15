//
//  JavaRepositoriesViewControllerTest.swift
//  Java RepositoriesTests
//
//  Created by Nicholas Forte on 14/05/25.
//

import XCTest
@testable import Java_Repositories

class JavaRepositoriesViewControllerTest: XCTestCase {
    
    var sut: JavaRepositoriesViewController?
    var viewModel: JavaRepositoryViewModelSpy?
    
    override func setUp() {
        super.setUp()
        
        setupJavaController()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
    }
    
    private func setupJavaController() {
        viewModel = JavaRepositoryViewModelSpy()
        sut = JavaRepositoriesViewController(viewModel: viewModel!)
    }
    
    func testTableViewConfig() {
        sut?.loadViewIfNeeded()
        
        XCTAssertNotNil(sut?.tableview)
        XCTAssertEqual(sut?.tableview.delegate as? JavaRepositoriesViewController, sut)
        XCTAssertEqual(sut?.tableview.dataSource as? JavaRepositoriesViewController, sut)
    }
    
    func testTableviewDelegateAndDatasource() {
        sut?.loadViewIfNeeded()
        
        viewModel?.fetchRepositories()
        
        let table = sut?.tableview
        let indexPath = IndexPath(row: 0, section: 0)
        
        XCTAssertEqual(table?.numberOfRows(inSection: 0), viewModel?.repositoryCount)
    }
}
