//
//  RepoCell.swift
//  DemoApp
//
//  Created by Mohamed Aglan on 10/2/23.
//

import UIKit

class RepoCell: UITableViewCell {
    
    //MARK: - IBOutLets -
    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoOwnerName: UILabel!
    @IBOutlet weak var repoDate: UILabel!
    
    
    //MARK: - LifeCycle Events -
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        repoImage.layer.cornerRadius = 8
    }
    
    
    
    //MARK: - Configure Cell -
    func configureCell(model: RepositoriesModel) {
        repoImage.setWith(url: model.owner?.avatarUrl)
        repoName.text = model.name
        repoOwnerName.text = model.owner?.login
    }
    
    
}
