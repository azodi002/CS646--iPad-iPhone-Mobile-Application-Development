//
//  StateTableViewController.swift
//  Assignment_4_project
//
//  Created by Omid Azodi on 10/28/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit

var my_index = 0
var table_rows:[String] = Array()


var state_abbreviation:[String] =
["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA"]

var state_capital:[String] =
["Montgomery", "Juneau", "Phoenix", "Little Rock",
 "Scramento", "Denver", "Hartford", "Dover", "Tallahassee",
 "Atlanta"
]

var state_date:[String] =
[
    "December 14,1819",
    "January 3, 1959",
    "February 14, 1912",
    "June 15, 1836",
    "September 9, 1850",
    "August 1, 1876",
    "January 9, 1788",
    "December 7,1787",
    "March 3, 1845",
    "January 2, 1788"
]

class StateTableViewController: UITableViewController
{

    @IBOutlet weak var back_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // read states from a property list
        let bundle_path_to_plist =
            Bundle.main.path(forResource:"StatePropertyList", ofType:"plist")
        
        if let bundle_unwrap = bundle_path_to_plist
        {
            let root_dict = NSDictionary(contentsOfFile:bundle_unwrap)
            
            if let root_dict_unwrap = root_dict
            {
                table_rows = root_dict_unwrap.object(forKey: "State_List") as! [String]
            }
        } // if let bundle_unwrap = bundle_path_to_plist
        
        
        //self.progView.layer.zPosition++;
        //[self.view addSubview:self.progView];
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return table_rows.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rows", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = table_rows[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        my_index = indexPath.row
        performSegue(withIdentifier: "StateCellSegue", sender: self)
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
