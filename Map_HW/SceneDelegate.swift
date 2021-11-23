//
//  SceneDelegate.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 02.11.2021.
//

import UIKit
import GoogleMaps

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coverView: UIView?
    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        GMSServices.provideAPIKey("AIzaSyAuW-cBcK81Fq22yEn92y_fdBeGL8n6qq0")
        guard let windowScene = (scene as? UIWindowScene) else { return }
        //windowScene.sizeRestrictions = UISceneSizeRestrictions().maximumSize
        window = UIWindow(windowScene: windowScene)
//        window?.bounds.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        //window?.bounds.size = CGSize(width: 400 , height: 1500)
        window?.makeKeyAndVisible()
        window?.sizeToFit()
        window?.clipsToBounds = true
        
        coordinator = ApplicationCoordinator()
        coordinator?.start()
        return
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print(#function)
        //coverView = nil
        //coverView?.removeFromSuperview()
//        let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
//        coverView = UIView(frame: rect)
//        self.window?.addSubview(coverView!)
        guard let view = coverView else { return }
        self.window?.willRemoveSubview(view)
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print(#function)
        let screenSize = UIScreen.main.bounds.size
        let rect = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        coverView = UIView(frame: rect)
        coverView?.backgroundColor = UIColor(displayP3Red: 1, green: 0.5, blue: 0.5, alpha: 1)
        //coverView.backgroundColor.saturation(0.5)
        self.window?.addSubview(coverView!)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        //coverView = nil
        print(#function)
        coverView?.removeFromSuperview()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print(#function)
        let screenSize = UIScreen.main.bounds.size
        let rect = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        coverView = UIView(frame: rect)
        coverView?.backgroundColor = UIColor(displayP3Red: 1, green: 0.5, blue: 0.5, alpha: 1)
        //self.window?.addSubview(coverView!)
        //coverView.backgroundColor.saturation(0.5)
    }


}

