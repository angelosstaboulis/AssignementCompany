//
//  LaunchesNetwork.swift
//  AssignmentMindera
//
//  Created by Angelos Staboulis on 19/8/21.
//

import Foundation
import Alamofire
import SwiftyJSON
class LaunchesNetwork{
    static let shared = LaunchesNetwork()
    var launchesArray:[LaunchesInfo]=[]
    func convertDayFromDate(json:JSON)->Int{
        let dateFormatter =  DateFormatter()
        let currentDate = Date()
        let launchDate = dateFormatter.date(from:json["launch_date_local"].stringValue)
        let dayLaunch = Calendar.current.component(.day, from: launchDate!)
        let dayCurrent = Calendar.current.component(.day, from: currentDate)
        return dayCurrent - dayLaunch
    }
    func setLaunchesInfo(json:JSON,item:Int)->LaunchesInfo{
        return LaunchesInfo(missionpatch: json[item]["links"]["mission_patch"].stringValue, missionName: json[item]["mission_name"].stringValue, dateTime: json[item]["launch_date_utc"].stringValue, rocket: json[item]["rocket"]["rocket_name"].stringValue + "/" + json[item]["rocket"]["rocket_type"].stringValue, days: self.convertDayFromDate(json:json), launch_success: json[item]["launch_success"].boolValue, wikipedia: json[item]["links"]["wikipedia"].stringValue)
    }
    func fillLaunchesArray(json:JSON)->[LaunchesInfo]{
        for item in 0..<json.count{
            self.launchesArray.append(self.setLaunchesInfo(json: json, item: item))
        }
        return launchesArray
    }
    func fetchLaunches(completion:@escaping ([LaunchesInfo])->()) {
        let urlCompanyInfo = URL(string: "https://api.spacexdata.com/v3/launches")
        let request = URLRequest(url: urlCompanyInfo!)
        AF.request(request).responseJSON { (dataResponse) in
            let json = JSON(dataResponse.value)
            completion(self.fillLaunchesArray(json: json))
        }
    }
}
