//
//  SplashVC.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

class RepositoriesController: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //MARK: - Properties -
    static func create() -> RepositoriesController {
        let vc = AppStoryboards.main.instantiate(RepositoriesController.self)
        return vc
    }
    
    private var reposModel: [RepositoriesModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - LifeCycle Events -
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getReposApi()
        setLeading(title: "Repositories")
    }
    
    
    
    //MARK: - Logic -
    private func registerCell() {
        tableView.register(cellType: RepoCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}


//MARK: - TableView DataSource -
extension RepositoriesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: RepoCell.self, for: indexPath)
        cell.configureCell(model: reposModel[indexPath.row])
        return cell
    }
    
}

//MARK: - TableViewDelegate -
extension RepositoriesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AppStoryboards.main.instantiate(RepositoriesDetails.self)
        vc.userId = reposModel[indexPath.row].id
        self.push(vc)
    }
}




//MARK: - Networking -
extension RepositoriesController {
    
    private func getReposApi() {
        showIndicator()
        RepoRouter.repositories.send { [weak self] (response:[RepositoriesModel]) in
            guard let self = self else {return}
            self.hideIndicator()
            self.reposModel = response
        }
    }
}
