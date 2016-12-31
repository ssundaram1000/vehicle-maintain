//
//  VehicleTableViewController.swift
//  VehicleMaintain
//
//  Created by Shridhar on 12/29/16.
//  Copyright © 2016 Shridhar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VehicleTableViewController: UITableViewController {
    

    //-- ToDo
    // make the JSON Data available to details screen
    // Click on the item should take me to details view page -- send the selected VIN to the details view in the segue
    // on ViewDidLoad, show the VIN Selected -- JUST to test the segue
    
    // Create a details view screen
    // Contains 2 sections -- Vehicle Content and then a table view with the tasks

    
    var activeRow = 0
    @IBOutlet var tableViewWidget: UITableView!
    //let url = "https://wo53w3qno8.execute-api.us-east-1.amazonaws.com/test/checklist/70044/JN1CV7AP8HM640077";
    //let url = "https://wo53w3qno8.execute-api.us-east-1.amazonaws.com/test/inventory/70044";
    let url = "https://wo53w3qno8.execute-api.us-east-1.amazonaws.com/test/inventory/tasks/70044/2"
    var inventoryJSON: JSON = JSON.null
    
    func getDealerVehicles() {
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                self.inventoryJSON = JSON(value)
                //print("JSON: \(self.inventoryJSON)")
                self.tableViewWidget.reloadData()
//                for (index,subJson):(String, JSON) in json {
//                    print("checkListDesc: \(subJson["checkListDesc"]) frequency: \(subJson["frequency"])")
//                }
            case .failure(let error):
                print(error)
            }
        }
    }

//    func getVehicles() {
//        let numSecsInDay:Int32 = 86400
//        let url2 = "https://www.nissanusa.com/dealercenter/rest/dealerInventory/listDealerInventoryByCriteria?extColorCode=&zipCode=&pageNumber=1&year=&dealerId=71304&intColorCode=&pageSize=&transmissionCode=&format=json&versionName=&bedLengthCode=&transmissionType=&vehicleCode=Q5&radius=&language=en&modelCode=&bodyStyleCode=&versionCode=&driveTrainCode=&channel=in"
//        Alamofire.request(url2, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                var json = JSON(value)
//                json = json["inventoryList"]
//                //print("JSON: \(json)")
//                for (index,subJson):(String, JSON) in json {
//                    var inventoryItem = subJson["inventory"]
//
//                    let vin = inventoryItem["vin"]
//                    let modelYear = inventoryItem["modelYear"]
//                    let baseName = inventoryItem["trimDetails"]["baseName"]
//                    let modelLineCode = inventoryItem["modelLineCode"]
//                    let color = inventoryItem["exteriorColor"]["title"]
//                    let swatchURL = inventoryItem["exteriorColor"]["swatchURL"]
//                    let dealerNum = "71304"
//                    let randomDays:Int32 = Int32(arc4random_uniform(100))
//                    let randomSecs:Int32 = -1 * numSecsInDay * randomDays
//                    let dateReceived = NSDate(timeIntervalSinceNow: TimeInterval(randomSecs) )
//                    
//                    
//                    
//                    let dayTimePeriodFormatter = DateFormatter()
//                    dayTimePeriodFormatter.dateFormat = "YYYY-MM-dd"
//                    let dateString = dayTimePeriodFormatter.string(from: dateReceived as Date)
//                    
//                    //print("\(subJson["inventory"]["vin"]) | \(subJson["inventory"]["trimDetails"]["baseName"]) | \(subJson["inventory"]["exteriorColor"]["title"])")
//                    print("insert into inventory values ('\(vin)', '\(modelYear)', '\(baseName)', '\(modelLineCode)', '\(color)', '\(swatchURL)', '\(dealerNum)', '\(dateString)'); ")
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getVehicles()
        getDealerVehicles()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (inventoryJSON == JSON.null) {
            return 0
        }
        else {
            print(inventoryJSON)
            return inventoryJSON.count
        }
    }

    func load_image(urlString:String) -> UIImage
    {
        let url = NSURL(string:urlString)
        let data = NSData(contentsOf:url! as URL)
        if data != nil {
            return UIImage(data:data! as Data)!
        }
        else {
            return UIImage()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell");
        let cell = Bundle.main.loadNibNamed("TaskListTableViewCell", owner: self, options: nil)?.first as! TaskListTableViewCell
        
        if (indexPath.row % 2 == 1) {
            cell.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        }
        
        cell.label1.text = inventoryJSON[indexPath.row]["baseName"].string! + " " + inventoryJSON[indexPath.row]["color"].string!;
        cell.label2.text = inventoryJSON[indexPath.row]["vin"].string!;

        // Configure the cell...
        //print (inventoryJSON[indexPath.row]["checkListDesc"])
        //cell.textLabel?.text = inventoryJSON[indexPath.row]["vin"].string! + inventoryJSON[indexPath.row]["swatchURL"].string!
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activeRow = indexPath.row;
        performSegue(withIdentifier: "toDetailViewController", sender: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "logout") {
            GIDSignIn.sharedInstance().signOut()
            // Shridhar: You have to do this to stop the navigation bar showing on other screens
            self.navigationController?.navigationBar.isHidden = true
        } else if (segue.identifier == "toDetailViewController") {
            let detailViewController = segue.destination as! VehicleDetailViewController
            detailViewController.activeRow = activeRow
        }
    }
    @IBAction func onLogout(_ sender: Any) {
        performSegue(withIdentifier: "logout", sender: self)
    }

}
