//
//  SceneDelegate.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 20.11.2022.
//

import UIKit
import CoreData
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let tabBarController = TabBarController()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

            // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
            // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
            let contentView = SwiftUIView().environment(\.managedObjectContext, context)


        guard let windowsScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowsScene.coordinateSpace.bounds)
        window?.windowScene = windowsScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

