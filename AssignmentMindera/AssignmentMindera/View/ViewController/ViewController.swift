//
//  ViewController.swift
//  AssignmentMindera
//
//  Created by Angelos Staboulis on 18/8/21.
//

import UIKit
import SDWebImage
import Toucan
import SafariServices
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SFSafariViewControllerDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lblLaunchSite: UILabel!
    @IBOutlet var lblValuation: UILabel!
    @IBOutlet var lblLaunchSites: UILabel!
    @IBOutlet var lblEmployees: UILabel!
    @IBOutlet var lblYear: UILabel!
    @IBOutlet var lblFounder: UILabel!
    @IBOutlet var lblCompany: UILabel!
    var companyinfoViewModel = CompanyInfoViewModel()
    var launchesinfoViewModel = LaunchesInfoViewModel()
    
    func fetchCompanyInfo(){
            self.companyinfoViewModel.fetchCompanyInfo { (info) in
                self.lblCompany.text = info.name
                self.lblYear.text = info.founded
                self.lblFounder.text = info.founder
                self.lblEmployees.text = String(info.employees)
                self.lblValuation.text = String(info.valuation)
                self.lblLaunchSite.text = String(info.launch_sites)
            }
    }
    func fetchLaunchessInfo(){
        self.launchesinfoViewModel.fetchLaunches { (array) in
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        fetchCompanyInfo()
        fetchLaunchessInfo()
        // Do any additional setup after loading the view.
    }
    
    
}
extension ViewController{
    func initView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LaunchesCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.launchesinfoViewModel.launchesArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LaunchesCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LaunchesCell
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickCell))
        tapGesture.numberOfTapsRequired = 1
        cell.tag = indexPath.row
        tapGesture.view?.tag = cell.tag
        cell.addGestureRecognizer(tapGesture)
        setupCell(indexPath: indexPath, cell: cell)
        return cell
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    @objc func clickCell(gesture:UITapGestureRecognizer){
        let safari = SFSafariViewController.init(url: URL(string: self.launchesinfoViewModel.launchesArray[gesture.view!.tag].wikipedia)!)
        safari.modalPresentationStyle = .fullScreen
        safari.delegate = self
        present(safari, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
    
    func setupCell(indexPath:IndexPath,cell:LaunchesCell){
        if indexPath.row < self.launchesinfoViewModel.launchesArray.count{
            cell.lblRocket.text = self.launchesinfoViewModel.launchesArray[indexPath.row].rocket
            cell.lblMissionName.text = self.launchesinfoViewModel.launchesArray[indexPath.row].missionName
            cell.lblDateTime.text = self.launchesinfoViewModel.launchesArray[indexPath.row].dateTime
            cell.lblDays.text = String(self.launchesinfoViewModel.launchesArray[indexPath.row].days)
            let urlMain = URL(string: self.launchesinfoViewModel.launchesArray[indexPath.row].missionpatch)
            let resize = SDImageResizingTransformer(size: CGSize(width: 80, height: 75), scaleMode: .aspectFit)
            cell.imgPatch!.sd_setImage(with: urlMain, placeholderImage: nil, options: .allowInvalidSSLCertificates, context: [.imageTransformer:resize])
            if self.launchesinfoViewModel.launchesArray[indexPath.row].launch_success {
                cell.imgResult.image = UIImage(named: "correct")
            }
            else{
                cell.imgResult.image = UIImage(named: "wrong")
            }
        }
    }
}
