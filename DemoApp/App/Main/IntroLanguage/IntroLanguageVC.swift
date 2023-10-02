//
//  IntroLanguageVC.swift
//
//  Created by Mohamed Aglan®
//


import UIKit

class IntroLanguageVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet weak private var arabicButton: UIButton!
    @IBOutlet weak private var englishButton: UIButton!
    
    //MARK: - Properties -
    
    
    //MARK: - Creation -
    static func create() -> IntroLanguageVC {
        let vc = AppStoryboards.main.instantiate(IntroLanguageVC.self)
        return vc
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureInitialDesign()
    }
    
    
    //MARK: - Design Methods -
    private func configureInitialDesign() {
        self.title = "".localized
    }
    
    //MARK: - Logic Methods -
    private func goToNext() {
        let vc = AppTabBarController.create()
        AppHelper.changeWindowRoot(vc: vc)
    }
    
    //MARK: - Actions -
    
    /*
     if current language is the selected one, No need to change semantic attribute, just go to next page
     */
    
    @IBAction private func arabicButtonPressed() {
        
        let vc = LoginVC.create()
        vc.isModalInPresentation = true
        let nav = BaseNav(rootViewController: vc)
        self.present(nav, animated: true)
        
//        guard !Language.isRTL() else {
//            goToNext()
//            return
//        }
//        Language.setAppLanguage(lang: Language.Languages.ar)
//        UIView.appearance().semanticContentAttribute = .forceRightToLeft
//        goToNext()
    }
    @IBAction private func englishButtonPressed() {
        
        guard Language.isRTL() else {
            goToNext()
            return
        }
        
        Language.setAppLanguage(lang: Language.Languages.en)
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        goToNext()
    }
}


//MARK: - Networking -
extension IntroLanguageVC {
    
}

//MARK: - Routes -
extension IntroLanguageVC {
    
}
