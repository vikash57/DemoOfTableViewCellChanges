//
//  SecondHomeViewController.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 23/06/23.
//

import UIKit

class SecondHomeViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    //MARK: Variable Declaration
    var selectRow = -1
    var rowSection:Int = -1
    var dict:[String:String]?
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
    }
    
    func configureUI() {
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    func registerCell() {
        tblView.register(UINib(nibName: "MusicListTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicListTableViewCell")
        tblView.register(UINib(nibName: "HeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderCell")
    }
    
    func configureUserData() {
//        if let name = dict?["name"] {
//            userNameLabel.text = name
//        }
    }

    
}
extension SecondHomeViewController : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionOfArray.count
    }
    

}
extension SecondHomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !sectionOfArray[section].isExpand {
            return 0
        }
        return sectionOfArray[section].name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "MusicListTableViewCell") as! MusicListTableViewCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tblView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderCell") as! HeaderCell
        
        cell.didSelect = {
            var indexpath = [IndexPath]()
            for i in self.sectionOfArray[section].name.indices {
                let index = IndexPath(row: i, section: section)
                indexpath.append(index)
            }
            let isExpanded = self.sectionOfArray[section].isExpand
            self.sectionOfArray[section].isExpand = !isExpanded
            if isExpanded {
                self.tblView.deleteRows(at: indexpath, with: .fade)
//                self.tblView.reloadSections(IndexSet(integer: section), with: .fade)
                
            }else {
//                self.tblView.reloadSections(IndexSet(integer: section), with: .fade)
                self.tblView.insertRows(at: indexpath, with: .fade)
            }
            //self.tblView.scrollsToTop
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
}
