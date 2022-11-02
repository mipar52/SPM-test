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
        
       let sb = UIStoryboard(name: "Main", bundle: Bundle(for: HomeViewController.self))
       let nextVC = sb.instantiateInitialViewController() as! HomeViewController
       
       let bundle = UIStoryboard(name: "Main", bundle: Bundle(for: HomeViewController.self))
       let vc = bundle.instantiateInitialViewController()!
       
        viewController.modalPresentationStyle = .fullScreen
        viewController.navigationController?.pushViewController(nextVC, animated: true)
        viewController.present(nextVC, animated: true)
       
       
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
