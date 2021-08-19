//
//  LaunchesCell.swift
//  AssignmentMindera
//
//  Created by Angelos Staboulis on 19/8/21.
//

import UIKit

class LaunchesCell: UITableViewCell {

    @IBOutlet var imgResult: UIImageView!
    @IBOutlet var imgPatch: UIImageView!
    @IBOutlet var lblDays: UILabel!
    @IBOutlet var lblRocket: UILabel!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var lblMissionName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        imgPatch.image = UIImage()
        imgResult.image = UIImage()
    }
}
