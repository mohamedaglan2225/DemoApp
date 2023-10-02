//
//  BaseNav.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

class BaseNav: UINavigationController {
    
    //MARK: - Properties -
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGesture()
        self.handleAppearance()
        
    }
    
    //MARK: - Design -
    private func handleAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: Theme.colors.mainColor, .font: UIFont.boldSystemFont(ofSize: 17)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        self.navigationBar.tintColor = Theme.colors.mainColor
//        appearance.backgroundColor = .white
    }
    private func setupGesture() {
        interactivePopGestureRecognizer?.delegate = self
        self.view.semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    }
    
}
extension BaseNav: UIGestureRecognizerDelegate {}

