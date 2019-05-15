//
//  ViewController.swift
//  Weather
//
//  Created by olli on 30.04.19.
//  Copyright © 2019 Oli Poli. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayMiniLabel: UILabel!
    @IBOutlet weak var miniConditionImageView: UIImageView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    
    @IBOutlet weak var myTimeLabel: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    var parsedResult: JSONAnswer?

    let manager = CLLocationManager()
    
    let gradientLayer = CAGradientLayer()
    
    let apiKey = "8578ae47b67ff52ffebacba310a72796"
    var lat = 11.344533                   // широта
    var lon = 104.33322                   // долгота
    var activityIndicator: NVActivityIndicatorView!
    let locationManager = CLLocationManager()
    var dayBoss: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.addSublayer(gradientLayer)

        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width - indicatorSize)/2, y: (view.frame.height - indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .pacman, color: UIColor.white, padding: 20.0)
        activityIndicator.backgroundColor = UIColor.lightGray
        view.addSubview(activityIndicator)
        
        locationManager.requestWhenInUseAuthorization()
        
        activityIndicator.startAnimating()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBlueGradientBackground()
        print("градиент принят")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric").responseJSON {
            response in
            self.activityIndicator.stopAnimating()
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                
                // из json сделаем data (для записи)
                let data = try! jsonResponse.rawData()
                
                // parsedResult - тут записаны все данные 
                self.parsedResult = try! JSONDecoder().decode(JSONAnswer.self, from: data)
                guard let parsedResult = self.parsedResult, let list = parsedResult.list.first else {
                    return
                }

                let city = parsedResult.city

                let listWeather = list.weather
                let weatherInf = listWeather[0]
                let mainInf = list.main
                let dateInf = list.dt_txt
                
                self.conditionImageView.image = UIImage(named: weatherInf.icon)
                self.miniConditionImageView.image = UIImage(named: weatherInf.icon)
                self.conditionLabel.text = weatherInf.main
                self.locationLabel.text = "\(city.name)"
                
                self.temperatureLabel.text = "\(Int(round(mainInf.temp)))°"
                self.tempMaxLabel.text = "\(Int(round(mainInf.temp_max)))°"
                self.tempMinLabel.text = "\(Int(round(mainInf.tempMin)))°"
                self.myTimeLabel.text = Date().timeWeather(date: dateInf)

                self.dayLabel.text = Date().dayOfWeek(date: dateInf)
                self.dayMiniLabel.text = Date().dayOfWeek(date: dateInf)
                
                let suffix = weatherInf.icon.suffix(1)
                if(suffix == "n") {
                    self.setGreyGradientBackground()
                } else {
                    self.setBlueGradientBackground()
                }
                
            }
        }
        self.locationManager.stopUpdatingLocation()
        print("локейшн отабдейтили")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        print("ОШИБКА ок")
    }

    func setBlueGradientBackground(){
        let topColor = UIColor(red: 27.0/255.0, green: 118.0/255.0, blue: 187.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 1.0/255.0, green: 166.0/255.0, blue: 158.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    func setGreyGradientBackground(){
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }

    // передача данных
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController: AllWeatherTableViewController = segue.destination as! AllWeatherTableViewController


        destViewController.listik = parsedResult?.list
    }
}

extension Date {
    func dayOfWeek(date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-d HH:mm:ss"
        let date1 = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "EEEE d MMM"

        return "\(dateFormatter.string(from: date1!).capitalized)"
    }
    
    func timeWeather(date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-d HH:mm:ss"
        let date1 = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm:ss"
        
        return "\(dateFormatter.string(from: date1!).capitalized)"
    }
}









