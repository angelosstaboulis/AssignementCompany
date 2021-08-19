//
//  LaunchesInfoViewModel.swift
//  AssignmentMindera
//
//  Created by Angelos Staboulis on 19/8/21.
//

import Foundation
class LaunchesInfoViewModel{
    var launchesArray:[LaunchesInfo]=[]
    
    var launchesNetwork:LaunchesNetwork!
    init(){
        launchesNetwork = LaunchesNetwork.shared
    }
    func fetchLaunches(completion:@escaping ([LaunchesInfo])->()) {
        launchesNetwork.fetchLaunches { (array) in
            self.launchesArray.append(contentsOf: array)
            completion(self.launchesArray)
        }
    }
}
