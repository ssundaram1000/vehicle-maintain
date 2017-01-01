//
//  ChecklistTableViewCell.swift
//  VehicleMaintain
//
//  Created by Shridhar on 12/31/16.
//  Copyright © 2016 Shridhar. All rights reserved.
//

import UIKit

class ChecklistTableViewCell: UITableViewCell {

    @IBOutlet var lblChecklist: UILabel!
    @IBOutlet var btnDone: UIButton!
    
    var vin = ""
    var checkListId = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onDone(_ sender: Any) {
        print("Will mark \(checkListId) done for \(vin)")
        btnDone.isHidden = true;
    }
    
}
