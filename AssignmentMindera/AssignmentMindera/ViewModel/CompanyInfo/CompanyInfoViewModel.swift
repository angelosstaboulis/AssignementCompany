//
//  CompanyInfoViewModel.swift
//  AssignmentMindera
//
//  Created by Angelos Staboulis on 19/8/21.
//

import Foundation
class CompanyInfoViewModel{
    var companyNetwork:CompanyInfoNetwork!
    init(){
        companyNetwork = CompanyInfoNetwork.shared
    }
    func fetchCompanyInfo(completion:@escaping (CompanyInfo)->()) {
        companyNetwork.fetchCompanyInfo { (companyinfo) in
            completion(companyinfo)
        }
    }
}
