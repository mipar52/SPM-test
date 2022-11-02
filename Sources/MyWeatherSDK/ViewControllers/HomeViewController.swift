//
//  HomeViewController.swift
//  MyWeatherApp
//
//  Created by Milan Parađina on 24.10.2022..
//

import UIKit
import CoreLocation
import MapKit

//TODO:
//app: polu krug -> UI pokazuje sunce/misec (od sest ujutro do sest popodne sunce) -> vremenska prognoza -> iz gps-a izvuci lokaciju pa onda prognozu iz toga
//+ bonus points -> na svaki event kad se app stavi iz backgrounda ili foreground -> svaki neku animaciju
//+ bonus points -> dodat lokalizaciju barem za dva, tri jezika -> neki label s "dobar dan npr."


//napravit SDK - taj SDK vrati ovaj VC
//napravit SP - viewcontroller vrati ovaj vc od vremena u stack

//bonus zadatak -> dodas oblake npr. ako je mostly sunny -> nek se oblaci krecu (neka lagana brzina :D)
//ako se na oblak tapne -> fade in/fade out
//za iduci tjedan potencijalno (za 2 tjedna) -> pogledat cmake -> izgenerirat projekt za dobit feel

class HomeViewController: UIViewController {
    
    
    let cityLabel = UILabel()
    let tempLabel = UILabel()
    
    let weatherInfoLabel = UILabel()
    let circleView = CircleView()

//MARK: Label setup
    let launchView : UIImageView = {
        var image = UIImage()
        if #available(iOS 13.0, *) {
            image = UIImage(systemName: "cloud.drizzle")!
        }
        let imageView = UIImageView(frame: CGRect(x: 20, y: 50, width: 374, height: 300))
        imageView.tintColor = .systemGreen
        imageView.image = image
        return imageView
    }()
    
    let launchField : UILabel = {
        let uiLable = UILabel()
        uiLable.frame = CGRect(x: 20, y: 275, width: 374, height: 150)
        uiLable.textAlignment = .center
        uiLable.font = .boldSystemFont(ofSize: 50)
        uiLable.textColor = .darkGray
        uiLable.text = "MyWeatherApp"
        return uiLable
    }()
    
    let launchBackground : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let greetingLabel : UILabel = {
       let label = UILabel()
        label.text = "Good day, sir".localized(key: "greeting_label")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        return label
    }()

    let utilities = Utilities()
    
    let locationManager = CLLocationManager()
    let weatherManager = WeatherHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            setupUI()
        } 
        setupCircleView()
        setupLables()
        
        locationManager.delegate = self
        requestLocationAccess()
        
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        launchBackground.frame = view.bounds
        view.addSubview(launchBackground)
        view.addSubview(launchField)
        view.addSubview(launchView)
        
    }
    
    @objc func appMovedToForeground() {
        print("App moved to forground!")
        view.willRemoveSubview(launchView)
        view.willRemoveSubview(launchField)
        view.willRemoveSubview(launchBackground)
        launchView.removeFromSuperview()
        launchField.removeFromSuperview()
        launchBackground.removeFromSuperview()
    }

//MARK: UI Setup
    
    @available(iOS 13.0, *)
    func setupUI() {
        
        let time = utilities.getHours()
        var viewPosition = CGRect()
    
        switch time {
        case 6..<12, 18..<24:
            viewPosition = CGRect(x: 180, y: 400, width: 130, height: 130)
        case 12,0:
            viewPosition = CGRect(x: 100, y: 400, width: 130, height: 130)
        case 12..<18,0...6:
            viewPosition = CGRect(x: 20, y: 400, width: 130, height: 130)
        default:
            viewPosition = CGRect(x: 100, y: 400, width: 130, height: 130)
        }
        
        let imageView = UIImageView(frame: viewPosition)
        
        if time >= 6 && time <= 18 {
            imageView.image = UIImage(systemName: "sun.max.fill")
            setupBackgroundImage(name: "background_image")
            circleView.layer.backgroundColor = UIColor.systemGreen.cgColor
        } else {
            imageView.image = UIImage(systemName: "moon.fill")
            setupBackgroundImage(name: "night-skies")
            circleView.layer.backgroundColor = UIColor.systemBlue.cgColor
        }
        
        imageView.backgroundColor = .clear
        imageView.tintColor = .systemYellow
        view.addSubview(imageView)
        circleView.addSubview(imageView)
    }
    
    func setupLables() {
        let time = utilities.getHours()
        var textColor = UIColor()
                
        if time > 6 && time <= 18 {
        textColor = UIColor.darkGray
        } else {
        textColor = UIColor.lightGray
        }
        
        cityLabel.frame = CGRect(x: 20, y: 50, width: 374, height: 100)
        cityLabel.font = .boldSystemFont(ofSize: 50)
        cityLabel.text = "Getting data.."
        
        cityLabel.textColor = textColor
        cityLabel.textAlignment = .center
        view.addSubview(cityLabel)

        tempLabel.frame = CGRect(x: 20, y: 180, width: 374, height: 50)
        tempLabel.font = .systemFont(ofSize: 30)
        tempLabel.textColor = textColor
        tempLabel.textAlignment = .center
        tempLabel.text = ""
        view.addSubview(tempLabel)
        
        weatherInfoLabel.frame = CGRect(x: 20, y: 220, width: 374, height: 50)
        weatherInfoLabel.font = .systemFont(ofSize: 30)
        weatherInfoLabel.text = ""
        weatherInfoLabel.textColor = textColor
        weatherInfoLabel.textAlignment = .center
        view.addSubview(weatherInfoLabel)
        
        greetingLabel.frame = CGRect(x: 20, y: 300, width: 374, height: 50)
        greetingLabel.textColor = textColor
        view.addSubview(greetingLabel)

    }
    
    func setupCircleView() {
        view.addSubview(circleView)

        circleView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            circleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            circleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            circleView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func setupBackgroundImage(name: String) {
        guard let image = UIImage(named: name) else {
            return
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        imageView.image = image
        view.addSubview(imageView)
    }

    //MARK: UI Update
    func updateLables(weatherInfo: WeatherInformation?) {
        
        let weatherSummary = weatherInfo?.weatherInfo
        
        cityLabel.text = weatherInfo?.city ?? "No data..\nTry reloading the application"
        tempLabel.text = "\(weatherInfo!.low) - \(String(describing: weatherInfo!.high))°C"
        weatherInfoLabel.text = weatherSummary
    }
    
    func updateUI(lat: String, long: String) {
        weatherManager.getYahooWeatherData(latitude: lat, longitude: long) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.updateLables(weatherInfo: success)
                }
            case .failure(let failure):
                print("Could not update UI! \(failure.localizedDescription)")
                DispatchQueue.main.async {
                    self.cityLabel.text = "No data..\nTry reloading the application"
                }
            }
        }
    }
}

//MARK: Location manager
extension HomeViewController: CLLocationManagerDelegate {
    
    func requestLocationAccess() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {print("Could not get location"); return }
        print("location: \(locValue.latitude) \(locValue.longitude)")
        let latitude = locValue.latitude
        let longitude = locValue.longitude
        
        DispatchQueue.main.async {
            self.updateUI(lat: "\(latitude)", long: "\(longitude)")
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
}
