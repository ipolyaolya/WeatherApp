//
//  AllWeatherTableViewCell.swift
//  Weather
//
//  Created by olli on 06.05.19.
//  Copyright © 2019 Oli Poli. All rights reserved.
//

import UIKit

extension UITableViewCell {
    var selectionColor: UIColor {
        set {
            let view = UIView()
            view.backgroundColor = newValue
            self.selectedBackgroundView = view
        }
        get {
            return self.selectedBackgroundView?.backgroundColor ?? UIColor.clear
        }
    }
}

class AllWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0/255.0, green: 166.0/255.0, blue: 158.0/255.0, alpha: 1.0)
        selectedBackgroundView = view    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func refresh(_ model: List) {
        dayLabel.text = Date().dayOfWeek(date: model.dt_txt)
        timeLabel.text = Date().timeWeather(date: model.dt_txt)
        imageImageView.image = UIImage(named: model.weather[0].icon)
        tempMaxLabel.text = "\(Int(round(model.main.temp_max)))"
        tempMinLabel.text = "\(Int(round(model.main.tempMin)))"
    }

}
