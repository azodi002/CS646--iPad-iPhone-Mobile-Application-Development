//
//  MajorTableViewController.swift
//  Assignment_5
//
//  Created by Omid Azodi on 11/17/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit
import Alamofire


var course_filter_name:String = ""

var class_id_list = [Int]()

// some classes don't have
// full title so use title when available
var class_title_list         = [String]()

var num_classes = 0

// id of top level course
// example: Astronomy, Computer Science, etc.
var top_level_course_id = 0

class MajorTableViewController: UITableViewController
{
    @IBOutlet weak var back_button: UIButton!
    
    // --------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        back_button.frame.size = CGSize(width: 20, height: 60)
        num_classes = 0
        course_filter_name = ""
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // --------------------------------------------------------------------

    // MARK: - Table view data source

    // --------------------------------------------------------------------
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // --------------------------------------------------------------------
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return g_title_array.count
        
    }

    // --------------------------------------------------------------------
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        
        cell.textLabel?.text = g_title_array[indexPath.row]

        return cell
    }
    
    // --------------------------------------------------------------------
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        course_filter_name = g_title_array[indexPath.row]
        top_level_course_id = g_id_array[indexPath.row]

        performSegue(withIdentifier: "filter_class_page", sender: self)
    }
    
    // --------------------------------------------------------------------
    
    @IBAction func back_button(_ sender: Any)
    {
        performSegue(withIdentifier: "back_to_account", sender:self)
    }
    
    // --------------------------------------------------------------------
    
} // class MajorTableViewController: UITableViewController

// --------------------------------------------------------------------
