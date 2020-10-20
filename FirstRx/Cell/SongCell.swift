//
//  SongCell.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/19/20.
//

import UIKit

class SongCell: BaseTBCell {

    
    @IBOutlet var title: UILabel!
    @IBOutlet var albumImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpData(song: Song){
        title.text = song.title
    }
}
