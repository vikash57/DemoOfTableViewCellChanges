//
//  HomeViewController.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 14/06/23.
//

import UIKit


class HomeViewController: UIViewController {

    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    var dict:[String:String]?
    var arrOfData:ModelData?
    var selectIndex:Int?
    var flag = Bool()
    var containSelectIndex:[Int] = []
    var tf:IndexPath?
    var selectCell = -1
    var selectIndex1:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUserData()
        configureUI()
        registerCell()
    }
    
    func configureUI() {
        tblView.delegate = self
        tblView.dataSource = self
        
        fetchData { data in
            self.arrOfData = data
            
            tblView.reloadData()
        }
    }

    @IBAction func logOutButtonAction(_ sender: Any) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        do{
            self.navigationController?.popViewController(animated: true)
        }
       
    }
    
    func configureUserData() {
        if let name = dict?["name"] {
            userNameLabel.text = name
        }
    }
    
    // MARK: Register table View cell
    
    func registerCell() {
        tblView.register(UINib(nibName: "MusicListTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicListTableViewCell")
    }

}
extension HomeViewController : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOfData?.music.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "MusicListTableViewCell") as! MusicListTableViewCell
        if let data = arrOfData?.music[indexPath.row] {
            cell.configureData(data)
        }
        
        if self.arrOfData?.music[indexPath.row].isExpanded == false {
            cell.describtionLabel.numberOfLines = 2
        }else {
            cell.describtionLabel.numberOfLines = 5
        }

        print("cell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tblView.reloadRows(at: [indexPath], with: .automatic)
        
        print(selectIndex)
        if selectIndex1 != indexPath.row {
            if selectIndex1 > -1 {
                let isExpanded = self.arrOfData?.music[selectIndex1].isExpanded
                if let isExpanded = isExpanded {
                    self.arrOfData?.music[selectIndex1].isExpanded = !isExpanded
                }
                if isExpanded! {
                    let indexPath = IndexPath(item: selectIndex1, section: indexPath.section)
                    self.tblView.reloadRows(at: [indexPath], with: .fade)
                }else {
                    
                    let indexPath = IndexPath(item: selectIndex1, section: indexPath.section)
                    self.tblView.reloadRows(at: [indexPath], with: .fade)
                }
            }
        }
        

        defer {
            let isExpanded = self.arrOfData?.music[indexPath.row].isExpanded
            if let isExpanded = isExpanded {
                self.arrOfData?.music[indexPath.row].isExpanded = !isExpanded
            }
            if isExpanded! {
                selectIndex1 = indexPath.row
                
                self.tblView.reloadRows(at: [indexPath], with: .fade)
            }else {
                selectIndex1 = indexPath.row
                self.tblView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        

    }
}
