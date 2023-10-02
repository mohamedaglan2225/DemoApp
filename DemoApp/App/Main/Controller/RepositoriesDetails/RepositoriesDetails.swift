//
//  IntroLanguageVC.swift
//
//  Created by Mohamed Aglan®
//


import UIKit

class RepositoriesDetails: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var repoDate: UILabel!
    @IBOutlet weak var repoUrl: UILabel!
    @IBOutlet weak var repoLanguage: UILabel!
    
    
    //MARK: - Properties -
    
    
    
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        getRepoDetailsApi(id: 26)
    }
    
    
    //MARK: - Business Logic -
    func formatDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month, .year], from: date, to: Date())
            
            if let months = components.month, months < 6 {
                dateFormatter.dateFormat = "EEEE, MMM dd, yyyy"
                return dateFormatter.string(from: date)
            } else if let years = components.year, years == 1 {
                return "1 year ago"
            } else if let years = components.year, years > 1 {
                return "\(years) years ago"
            } else if let months = components.month, months > 0 {
                return "\(months) months ago"
            }
        }
        
        return "Invalid date format"
    } 
    
    
    
    //MARK: - Actions -

    
}


//MARK: - Networking -
extension RepositoriesDetails {
    
}

//MARK: - Routes -
extension RepositoriesDetails {
    
    private func getRepoDetailsApi(id: Int) {
        self.showIndicator()
        RepoRouter.repositoriesDetails(id: id).send { [weak self] (response:RepoDetailsModel) in
            guard let self = self else {return}
            self.hideIndicator()
            self.userImage.setWith(url: response.owner?.avatarUrl)
            self.userName.text = response.owner?.login
            self.repoDate.text = formatDate(dateString: response.createdAt ?? "")
            self.repoDescription.text = response.description
            self.repoUrl.text = response.url
            self.repoLanguage.text = response.language
        }
    }
}
