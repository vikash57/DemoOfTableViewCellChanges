//
//  MusicListTableViewCell.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 16/06/23.
//

import UIKit

class MusicListTableViewCell: UITableViewCell {

    @IBOutlet weak var describtionHeight: NSLayoutConstraint!
    @IBOutlet weak var cellSelectButton: UIButton!
    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    //MARK: Variable Declaration
   var flag = true
    var didSelect:(()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(_ data : Music) {
        profileImageView.image = UIImage(named: data.img)
        musicNameLabel.text = data.titleName
        describtionLabel.text = data.describtion
    }
    func configureData1(_ data : MusicList) {
        profileImageView.image = UIImage(named: data.img)
        musicNameLabel.text = data.titleName
        describtionLabel.text = data.describtion
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func cellSelectButtonAction(_ sender: Any) {
        print("hello")
        if flag == true {
            flag = false
            describtionLabel.numberOfLines = 5
            didSelect?()
        }else {
            flag = true
            describtionLabel.numberOfLines = 2
            didSelect?()
        }
    }
    
    func changeLaout() {
        
    }
    
}
