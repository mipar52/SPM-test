//
//  WeatherSDK.swift
//  MyWeatherApp
//
//  Created by Milan Parađina on 02.11.2022..
//

import Foundation
import UIKit

public class MyWeatherSDK {
    public init() {}
    
   public func presentWeatherVC(_ viewController: UIViewController) {
        let navController = viewController.navigationController
        let weatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weatherVC")
        
    
        viewController.modalPresentationStyle = .fullScreen
        viewController.navigationController?.pushViewController(weatherViewController, animated: true)
        viewController.present(weatherViewController, animated: true)
        print("pushing vc")
//        if #available(iOS 13.0, *) {
//            if var topController = UIApplication.shared.keyWindow?.rootViewController  {
//                while let presentedViewController = topController.presentedViewController {
//                    topController = presentedViewController
//                }
//                viewController.modalPresentationStyle = .fullScreen
//                topController.present(viewController, animated: true, completion: nil)
//            }
//        }
    }
}
