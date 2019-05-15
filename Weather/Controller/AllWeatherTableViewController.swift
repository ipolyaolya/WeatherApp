//
//  AllWeatherTableViewController.swift
//  Weather
//
//  Created by olli on 06.05.19.
//  Copyright © 2019 Oli Poli. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation

class AllWeatherTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var listik: [List]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listik?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AllWeatherTableViewCell {
            
            guard let item = listik?[indexPath.row] else {
                return cell
            }
            cell.refresh(item)
            return cell
        }
        
        return UITableViewCell()  // если прийдет nil - вернется пустая ячейка
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
 
}
