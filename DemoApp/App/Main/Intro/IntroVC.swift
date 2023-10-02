//
//  IntroVC.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

class IntroVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var textView: UITextView!
    
    //MARK: - Properties -
    var image: String?
    var titleText: String?
    var body: String?
    
    //MARK: - Creation -
    static func create(image: String?, title: String?, body: String?) -> IntroVC {
        let vc = AppStoryboards.main.instantiate(IntroVC.self)
        vc.image = image
        vc.titleText = title
        vc.body = body
        return vc
    }
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
    }
    
    //MARK: - Design -
    func setData() {
        self.titleLabel.text = titleText
        self.textView.text = body
        self.imageView.setWith(url: self.image)
        self.imageView.contentMode = .scaleAspectFill
    }
    
}
