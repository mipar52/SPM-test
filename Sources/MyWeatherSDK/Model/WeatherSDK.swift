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
//       let weatherViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "weatherVC")
        
       let bundle = Bundle(for: HomeViewController.self)
       let homeVC = HomeViewController(nibName: nil, bundle: bundle)
       
        viewController.modalPresentationStyle = .fullScreen
        viewController.navigationController?.pushViewController(homeVC, animated: true)
        viewController.present(homeVC, animated: true)
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
