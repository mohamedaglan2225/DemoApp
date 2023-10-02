//
//  SplashVC.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

class SplashVC: BaseVC {
    
    //MARK: - IBOutlets -
    
    
    //MARK: - Properties -
    static func create() -> SplashVC {
        let vc = AppStoryboards.main.instantiate(SplashVC.self)
        return vc
    }
    
    // MARK: - UIViewController Events -
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK: - IBActions -
    
    
}
