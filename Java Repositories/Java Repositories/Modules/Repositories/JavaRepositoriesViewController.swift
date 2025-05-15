//
//  ViewController.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 08/05/25.
//

import UIKit
import Combine

class JavaRepositoriesViewController: UIViewController {
    
    // MARK: - UI Components
    lazy var tableview: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(JavaRepoCell.self, forCellReuseIdentifier: JavaRepoCell.identifier)
        table.separatorStyle = .none
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return table
    }()
    
    // MARK: - Properties
    private let cellHeight: CGFloat = 130
    private var viewModel: JavaRepositoriesBusinessLogic
    private var cancellables = Set<AnyCancellable>()
    
    
    // MARK: - Initializers
    init(viewModel: JavaRepositoriesBusinessLogic = JavaRepositoriesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = JavaRepositoriesViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        configureUI()
        bindViewModel()
        viewModel.fetchRepositories()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        title = "Github JavaPop"
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    private func bindViewModel() {
        viewModel.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableview.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.repositoriesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableview.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.imagePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] avatarInfo in
                self?.updateAvatarImage(at: avatarInfo.index,
                                        image: avatarInfo.image)
            }
            .store(in: &cancellables)
    }
    
    private func updateAvatarImage(at index: Int, image: UIImage?) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableview.cellForRow(at: indexPath) as? JavaRepoCell {
            cell.imgAvatar.image = image
        }
    }
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension JavaRepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositoryCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JavaRepoCell.identifier) as? JavaRepoCellProtocol
        let repo = viewModel.repository(at: indexPath.row)
        cell?.addInfo(repo)
        viewModel.fetchImage(for: indexPath.row, imageURL: repo.owner.avatarUrl)
        return cell as? UITableViewCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = viewModel.repository(at: indexPath.row)
        let projectDetail = viewModel.getRepoInfo(repo)
        let viewModel: PullRequestBusinessLogic = PullRequestViewModel(prInfo: projectDetail)
        let controller = PullRequestViewController(viewModel: viewModel)
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
