//
//  CourseTableCell.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/10/5.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import UIKit

class CourseTableCell: UITableViewCell {

    @IBOutlet weak var courseIdLabel: UILabel!
    
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
