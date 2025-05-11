//
//  ViewController.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 08/05/25.
//

import UIKit
import Combine

class JavaRepositoriesViewController: UIViewController {
    
    lazy var tableview: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    private let kCellHeight: CGFloat = 80
    private var viewModel: JavaRepositoriesBusinessLogic
    private var cancellables = Set<AnyCancellable>()
    
    
    init(viewModel: JavaRepositoriesBusinessLogic = JavaRepositoriesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = JavaRepositoriesViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Github JavaPop"
        
        setUpTableView()
        bindViewModel()
        viewModel.fetchRepositories()
    }
    
    private func bindViewModel() {
        
        viewModel.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.tableview.reloadData()
            }.store(in: &cancellables)
        
        viewModel.repositoriesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableview.reloadData()
            }
            .store(in: &cancellables)

    }
    
    private func setUpTableView() {
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                              constant: 8.0),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -8.0)
        ])
    }
    
}

extension JavaRepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositoryCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)

        let repo = viewModel.repository(at: indexPath.row)
        cell.textLabel?.text = repo.repositoryName
        cell.detailTextLabel?.text = "⭐️ \(repo.starsCount) | 🍴 \(repo.forksCount)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = viewModel.repository(at: indexPath.row)
        let projectDetail = viewModel.getRepoInfo(repo)
        let viewModel: JavaRepoDetailBussinessLogic = JavaRepoDetailViewModel(repoDetails: projectDetail)
        let controller = JavaRepoDetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
            
        if offsetY > contentHeight - frameHeight * 1.5 {
            viewModel.fetchRepositories()
        }
    }
    
}
