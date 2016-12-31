//
//  VehicleDetailViewController.swift
//  VehicleMaintain
//
//  Created by Shridhar on 12/31/16.
//  Copyright © 2016 Shridhar. All rights reserved.
//

import UIKit

class VehicleDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var activeRow = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Active row \(activeRow)")

        // Do any additional setup after loading the view.
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
        return 4;
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell");
        cell.textLabel?.text = "Row \(indexPath.row)"
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
