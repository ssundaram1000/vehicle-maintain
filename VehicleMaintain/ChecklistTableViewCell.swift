//
//  ChecklistTableViewCell.swift
//  VehicleMaintain
//
//  Created by Shridhar on 12/31/16.
//  Copyright © 2016 Shridhar. All rights reserved.
//

import UIKit
import Alamofire

class ChecklistTableViewCell: UITableViewCell {
    
    var vin = "";
    var checkListId = "";
    @IBOutlet var lblChecklist: UILabel!
    @IBOutlet var btnDone: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onDone(_ sender: Any) {
        //print("Will mark \(checkListId) done for \(vin)")
        // I may need to show the waiting indicator...
        addActivity();
        btnDone.isHidden = true;
    }

    func addActivity() {
        let url = "https://wo53w3qno8.execute-api.us-east-1.amazonaws.com/test/activities/\(vin)/\(checkListId)";
        // set didCompleteActivity = true on parent tableView
        
        Alamofire.request(url, method: .post).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Success in adding")
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
