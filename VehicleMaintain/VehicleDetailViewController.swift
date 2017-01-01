//
//  VehicleDetailViewController.swift
//  VehicleMaintain
//
//  Created by Shridhar on 12/31/16.
//  Copyright © 2016 Shridhar. All rights reserved.
//

import UIKit
import SwiftyJSON

class VehicleDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var lblBaseName: UILabel!
    @IBOutlet var lblColor: UILabel!
    @IBOutlet var lblVIN: UILabel!
    @IBOutlet var tableViewWidget: UITableView!


    var vehicleJson: JSON = JSON.null
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblBaseName.text = vehicleJson["modelYear"].string! + " " + vehicleJson["baseName"].string!
        lblColor.text = vehicleJson["color"].string!
        lblVIN.text = vehicleJson["vin"].string!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // Happens just before seque happens
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "toVehicleListViewController") {
//            let secondViewController = segue.destination as! SecondViewController
//            secondViewController.activeRow = activeRow
//        }
//    }
//    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicleJson["tasks"].count;
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell");
//        cell.textLabel?.text = vehicleJson["tasks"][indexPath.row]["checkListDesc"].string!
        
        
        let cell = Bundle.main.loadNibNamed("ChecklistTableViewCell", owner: self, options: nil)?.first as! ChecklistTableViewCell
        
        if (indexPath.row % 2 == 1) {
            cell.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        }
        
        cell.lblChecklist.text = vehicleJson["tasks"][indexPath.row]["checkListDesc"].string!
        cell.vin = vehicleJson["vin"].string!
        cell.checkListId = vehicleJson["tasks"][indexPath.row]["checkListId"].string!
        
        return cell;
    }
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        activeRow = indexPath.row;
//        performSegue(withIdentifier: "toSecondViewController", sender: nil)
//    }
    
    @IBAction func backToList(_ sender: Any) {
        //performSegue(withIdentifier: "toVehicleListViewController", sender: nil);
        navigationController?.popViewController(animated:true)
    }


}




//From Instagram
//func addFollowing(following: String) {
//    let identityId = credentialsProvider.identityId! as String
//    
//    let mapper = AWSDynamoDBObjectMapper.default()
//    let add = Follower()
//    
//    add?.id = NSUUID().uuidString
//    add?.follower = identityId
//    add?.following = following
//    
//    mapper.save(add!)
//}
//
//func removeFollowing(following: String) {
//    let identityId = credentialsProvider.identityId! as String
//    
//    let map = AWSDynamoDBObjectMapper.default()
//    self.databaseService.findFollower(follower: identityId, following: following, map: map).continue({ (task:AWSTask) -> AnyObject? in
//        if (task.error != nil) {
//            print(task.error ?? "Unknown Error")
//        }
//        
//        if (task.exception != nil) {
//            print(task.error ?? "Unknown Error")
//        }
//        
//        if (task.result != nil) {
//            let followings = task.result as! [Follower]
//            
//            for following in followings {
//                map.remove(following)
//            }
//        }
//        
//        return nil
//    })
//}
