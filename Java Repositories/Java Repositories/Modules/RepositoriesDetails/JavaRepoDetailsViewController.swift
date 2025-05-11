//
//  JavaRepoDetailsViewController.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 11/05/25.
//

import Foundation
import UIKit

class JavaRepoDetailsViewController: UIViewController {
    
    private let viewModel: JavaRepoDetailBussinessLogic
    
    init(viewModel: JavaRepoDetailBussinessLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {        
        view.backgroundColor = .white
        title = viewModel.repoDetails.repoName
    }
}
