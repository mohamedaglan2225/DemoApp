//
//  UserDetailsController.swift
//  DemoApp
//
//  Created by Mohamed Aglan on 10/2/23.
//

import UIKit

class UserDetailsController: BaseVC {
    
    //MARK: - IBOutLets -
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userTwitterName: UILabel!
    
    
    
    
    
    //MARK: - Properties -
    var userModel: UserDetailsModel?
    
    
    
    
    //MARK: - LifeCycle Events -
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = userModel else {return}
        handleResponseApi(model: model)
    }
    
    

}


//MARK: - Extensions -
extension UserDetailsController {
    
    private func handleResponseApi(model: UserDetailsModel) {
        userImage.setWith(url: model.avatarUrl)
        userName.text = model.name
        companyName.text = model.company
        userLocation.text = model.location
        userEmail.text = model.email
        userTwitterName.text = model.twitterUsername
        if userEmail.text == nil {
            userEmail.text = "------"
        }
        if userTwitterName.text == nil {
            userTwitterName.text = "------"
        }

    }
    
    
}
