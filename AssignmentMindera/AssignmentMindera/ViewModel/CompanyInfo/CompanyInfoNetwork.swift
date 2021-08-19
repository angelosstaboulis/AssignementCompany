//
//  CompanyInfoNetwork.swift
//  AssignmentMindera
//
//  Created by Angelos Staboulis on 19/8/21.
//

import Foundation
import Alamofire
import SwiftyJSON
class CompanyInfoNetwork{
    static let shared = CompanyInfoNetwork()
    func setHeaderQuarters(json:JSON)->HeadQuarters{
       return  HeadQuarters(address: json["headquarters"]["address"].stringValue, city: json["headquarters"]["city"].stringValue, state: json["headquarters"]["state"].stringValue)
    }
    func setCompanyInfo(json:JSON)->CompanyInfo{
        return  CompanyInfo(name: json["name"].stringValue, founder: json["founder"].stringValue, founded: json["founded"].stringValue, employees: json["employees"].intValue, vehicles: json["vehicles"].intValue, launch_sites: json["launch_sites"].intValue, test_sites: json["test_sites"].intValue, ceo: json["ceo"].stringValue, cto: json["cto"].stringValue, coo: json["coo"].stringValue, cto_propulsion: json["cto_propulsion"].stringValue, valuation: json["valuation"].intValue, headerQuarters: setHeaderQuarters(json: json), summary: json["summary"].stringValue)
    }
    func fetchCompanyInfo(completion:@escaping (CompanyInfo)->()) {
        let urlCompanyInfo = URL(string: "https://api.spacexdata.com/v3/info")
        let request = URLRequest(url: urlCompanyInfo!)
        AF.request(request).responseJSON { (dataResponse) in
            let json = JSON(dataResponse.value)
            completion(self.setCompanyInfo(json: json))
        }
    }
}
