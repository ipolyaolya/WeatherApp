//
//  WeatherForecastViewController.swift
//  Weather
//
//  Created by olli on 06.05.19.
//  Copyright © 2019 Oli Poli. All rights reserved.
//


import UIKit

class WeatherForecastViewController: UIViewController {

    @IBOutlet weak var bigScrollView: UIScrollView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var allWeatherStackView: UIStackView!
    @IBOutlet weak var weather1ImageView: UIImageView!
    @IBOutlet weak var nameDay1Label: UILabel!
    @IBOutlet weak var tempDayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
