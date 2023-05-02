//
//  TblListViewController.swift
//  WisdomLeaf
//
//  Created by Zindal on 02/05/23.
//

import UIKit
import MBProgressHUD

class TblListViewController: UIViewController {

    @IBOutlet var lblNoDataMessage: UILabel!
    @IBOutlet var tblView: UITableView!
    
    var dataArr: [AutherInfoViewModel]! = []
    var selectedDataArr: [AutherInfoViewModel]! = []
    let refreshControl = UIRefreshControl()
    var pageCount : Int! = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchList()
        self.title = "Auther"
        
        // Adding refresh control to table
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblView.addSubview(refreshControl) // not required when using UITableViewController

    }
    
    // MARK: Handling HUD
    func showHUD() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    // Refresh control target function
    @objc func refresh(_ sender: AnyObject) {
        // This will refresh list from page 1.
        dataArr = []
        pageCount = 1
        fetchList()
        refreshControl.endRefreshing()
    }
    
    // MARK: Fetching data from API
    func fetchList(){
        showHUD()
        NetworkServices.shared.getAutherList(page: pageCount) { (result) in
            self.hideHUD()
            switch result {
            case .success(let response):
                self.handleSuccessResponse(response: response)
            case .failure(let error):
                self.handleFailedResponse(error: error)
            }
        }
    }
    
    // MARK: Response handlers
    func handleFailedResponse(error:String) {
        self.lblNoDataMessage.isHidden = false
        self.lblNoDataMessage.text = error
        self.tblView.isHidden = true
    }
    
    func handleSuccessResponse(response:AutherListModel) {
        self.dataArr.append(contentsOf: response)
        self.tblView.isHidden = false
        self.lblNoDataMessage.isHidden = true
        self.tblView.reloadData()
    }

}

extension TblListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblListCell") as? TblListCell
        let data = self.dataArr[indexPath.row]
        cell?.setUpCell(data: data, selectedData: selectedDataArr)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.dataArr[indexPath.row]
        if selectedDataArr.contains(where: { $0.id == data.id }) {
            selectedDataArr.removeAll(where: { $0.id == data.id })
        } else {
            selectedDataArr.append(data)
        }
        tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (dataArr.count - 1) {
            self.pageCount += 1
            self.fetchList()
        }
    }
}
