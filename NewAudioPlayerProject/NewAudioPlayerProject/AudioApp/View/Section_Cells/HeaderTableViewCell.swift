//
//  HeaderTableViewCell.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 23/06/23.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var sideButton: UIButton!
    @IBOutlet weak var titleName: UILabel!
    
    //MARK: Variable Declaration
    var didSelect:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func sideButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func selectCellAction(_ sender: Any) {
        didSelect?()
        
    }
    
    
}
//chevron.right.2
//chevron.compact.down
