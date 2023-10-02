//
//  SplashVC.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

class SplashVC: BaseVC {
    
    //MARK: - IBOutlets -
    
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: - Properties -
    static func create() -> SplashVC {
        let vc = AppStoryboards.main.instantiate(SplashVC.self)
        return vc
    }
    
    // MARK: - UIViewController Events -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDesign()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.goNext()
        }
    }
    
    //MARK: - Design Methods -
    func setupDesign() {
        self.stackView.animateToTop()
        let window = UIApplication.shared.windows.first
        window?.backgroundColor = Theme.colors.mainColor
    }
    
    //MARK: - Logic Methods -
    private func goNext() {
        switch UserDefaults.isFirstTime {
        case true:
            self.goToLanguage()
        case false:
            self.goToHome()
        }
    }
    
    //MARK: - Route Methods -
    private func goToLanguage() {
        let vc = IntroLanguageVC.create()
        AppHelper.changeWindowRoot(vc: vc)
    }
    
    private func goToIntro() {
        var vcs = [UIViewController]()

        for i in 1 ... 5 {
            vcs.append(IntroVC.create(image: "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__340.jpg", title: "title \(i)", body: "body \(i)"))
        }


        let vc = IntroPageController.create(subVCs: vcs)
        AppHelper.changeWindowRoot(vc: vc)
    }
    
    private func goToHome() {
        let vc = AppTabBarController.create()
        AppHelper.changeWindowRoot(vc: vc)
    }
    
    //MARK: - IBActions -
    
}
