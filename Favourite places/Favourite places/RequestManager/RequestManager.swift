//
//  RequestManager.swift
//  Favourite places
//
//  Created by Serhii Mokliuchenko on 14.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RequestManager {
    
    func getDirection(origin: String, destination: String, selectedMode: String, completion: @escaping([JSON]) -> ()) {
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=\(selectedMode)&key=AIzaSyBZqaVnSdIJP4ghK3Xq1j6NFfrAgE3I40s"
        
        AF.request(url).responseJSON { (response) in
            let json = try! JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            completion(routes)
        }
    }
}
