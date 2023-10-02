//
//  AppDelegate.swift
//
//  Created by Mohamed Aglan®
//

import UIKit
import Firebase
//import GoogleMaps
import IQKeyboardManager


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Properties -
    let gcmMessageIDKey = "gcm.message_id"
    let googleMapKey = UserDefaults.googleMapKey//"Add default value google key"
    
    //MARK: - Initializer -
    override init() {
        super.init()
        UIFont.overrideInitialize()
    }
    
    
    //MARK: - App LifeCycle -
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        //MARK: - Fack data -
        self.setFakeData()
        
        //MARK: - Font -
        Theme.current.setupFont()
        
        //MARK: - Localization
        Bundle.swizzleLocalization()
        
        //MARK: - Keyboard -
        self.handleKeyboard()
        
        //MARK: - Google Map Key -
        self.handleGoogleMap()
        
        //MARK: - FCM -
//        self.handleFCMFor(application)
        
        return true
    }
    
    
}

extension AppDelegate {
    
    //MARK: - FCM -
    private func handleFCMFor(_ application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
    
    //MARK: - Keyboard -
    private func handleKeyboard() {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().toolbarTintColor = Theme.colors.whiteColor
        let disabledVCs: [UIViewController.Type] = []
        IQKeyboardManager.shared().disabledDistanceHandlingClasses.addObjects(from: disabledVCs)
    }
    
    //MARK: - Google Maps -
    private func handleGoogleMap() {
//        GMSServices.provideAPIKey(self.googleMapKey)
    }
    
    //MARK: - Fack data -
    private func setFakeData() {
    //    UserDefaults.isLogin = false
    //    UserDefaults.isFirstTime = true
        UserDefaults.accessToken = "214|VSnj6aeHhfZOYJ4DPKrLcuVOKqn1GqNybM29yBqb"
    }
}
