//
//  NoteCell.swift
//  Kodluyoruz-NoteAppRx
//
//  Created by XCODE on 13.09.2019.
//  Copyright © 2019 XCODE. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    var clicked: (() -> Void)?
    
    static let identifier = "NoteCell"
    static let estimatedRowHeight: CGFloat = 50
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
    
}
