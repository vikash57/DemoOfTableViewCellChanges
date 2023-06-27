//
//  HeaderCell.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 23/06/23.
//

import UIKit

class HeaderCell: UITableViewHeaderFooterView {

    @IBOutlet weak var userNameLabel: UILabel!
    
    //MARK: Variable Declaration
    var didSelect:(()->())?

    @IBAction func cellButton(_ sender: Any) {
        didSelect?()
    }
    
    
    
    
}
