//
//  IntroLanguageVC.swift
//
//  Created by Mohamed Aglan®
//


import UIKit

class RepositoriesDetails: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var repoDate: UILabel!
    @IBOutlet weak var repoUrl: UILabel!
    @IBOutlet weak var repoLanguage: UILabel!
    
    
    //MARK: - Properties -
    var userId: Int?
    private var ownerLogin:String?
    
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        handleInitialDesign()
    }
    
    
    //MARK: - Handle Initial Load -
    private func handleInitialDesign() {
        scrollView.alpha = 0
        guard let id = userId else {return}
        getRepoDetailsApi(id: id)
    }
    
    
    //MARK: - Business Logic -
    func formatDate(dateString: String) -> String {
        // Change Date Format To Calculate if the date is less than 6 months ago, use the following format Thursday, Oct 22, 2020.
        // else use: “8 months ago”, “2 years ago” etc
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
    @IBAction func showMoreButtonPressed(_ sender: UIButton) {
        guard let loginId = ownerLogin else {return}
        self.getUserDetailsApi(name: loginId)
    }
    
    
}


//MARK: - Networking -
extension RepositoriesDetails {
    
    private func getRepoDetailsApi(id: Int) {
        self.showIndicator()
        RepoRouter.repositoriesDetails(id: id).send { [weak self] (response:RepoDetailsModel) in
            guard let self = self else {return}
            self.hideIndicator()
            self.scrollView.alpha = 1
            self.userImage.setWith(url: response.owner?.avatarUrl)
            self.userName.text = response.owner?.login
            self.repoDate.text = formatDate(dateString: response.createdAt ?? "")
            self.repoDescription.text = response.description
            self.repoUrl.text = response.url
            self.repoLanguage.text = response.language
            self.ownerLogin = response.owner?.login
        }
    }
    
    
    
    private func getUserDetailsApi(name: String) {
        showIndicator()
        RepoRouter.users(name: name).send { [weak self] (response:UserDetailsModel) in
            guard let self = self else {return}
            self.hideIndicator()
            let vc = AppStoryboards.main.instantiate(UserDetailsController.self)
            vc.userModel = response
            self.push(vc)
        }
    }
    
}
