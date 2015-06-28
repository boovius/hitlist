//
//  ActivityCell.swift
//  HitList
//
//  Created by Joshua Book on 6/11/15.
//  Copyright (c) 2015 Boovius Projects. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {

    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var activityTitle: UITextView!
    @IBOutlet weak var doButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.orangeColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
