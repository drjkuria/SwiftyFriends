//
//  FriendTableViewCell.swift
//  SwiftyFriends
//
//  Created by Jonah Kuria on 2016/11/07.
//  Copyright © 2016 Jonah Kuria. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var lastSeenLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
