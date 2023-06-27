//
//  ThirdViewController.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 23/06/23.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    //MARK: Variable declaration
    var dict:[String:String]?
    var arrOfData:DescriptionData?
    var didSlectCell:IndexPath?
    var flag = false
    var flag1 = false
    var sectionOfArray = [ExpendableName(isExpand: false, name: ["vikash","Aman","Saurabh","Ashwani","Prince","Sachin"]),
                          ExpendableName(isExpand: false, name: ["vikash","Aman","Saurabh","Ashwani","Prince","Sachin"]),
                          ExpendableName(isExpand: false, name: ["vikash","Aman","Saurabh","Ashwani","Prince","Sachin"]),
                          ExpendableName(isExpand: false, name: ["vikash","Aman","Saurabh","Ashwani","Prince","Sachin"]),
                          ExpendableName(isExpand: false, name: ["vikash","Aman","Saurabh","Ashwani","Prince","Sachin"]),
                          ExpendableName(isExpand: false, name: ["vikash","Aman","Saurabh","Ashwani","Prince","Sachin"])]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        registerCell()
        
        fetchData1 { data in
            self.arrOfData = data
            self.tblView.reloadData()
        }
    }
    

    func configureUI() {
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    func registerCell() {
        tblView.register(UINib(nibName: "MusicListTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicListTableViewCell")
        tblView.register(UINib(nibName: "HeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderCell")
    }

}
extension ThirdViewController : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrOfData?.playList.count ?? 0
    }
}
extension ThirdViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrOfData?.playList[section].musicList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "MusicListTableViewCell") as! MusicListTableViewCell
        if let data = arrOfData?.playList[indexPath.section].musicList[indexPath.row] {
            cell.configureData1(data)
        }
        
        if arrOfData?.playList[indexPath.section].musicList[indexPath.row].isExpanded == false {
            cell.describtionLabel.numberOfLines = 2
        }else {
            cell.describtionLabel.numberOfLines = 5
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tblView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderCell") as! HeaderCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isExpanded = self.arrOfData?.playList[indexPath.section].musicList[indexPath.row].isExpanded
        if let isExpanded = isExpanded {
            self.arrOfData?.playList[indexPath.section].musicList[indexPath.row].isExpanded = !isExpanded
        }
        if isExpanded! {
            self.tblView.reloadRows(at: [indexPath], with: .fade)
        }else {
            self.tblView.reloadRows(at: [indexPath], with: .fade)
        }
    }
}
