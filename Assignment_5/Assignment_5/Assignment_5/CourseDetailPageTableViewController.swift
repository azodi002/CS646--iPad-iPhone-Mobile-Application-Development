//
//  CourseDetailPageTableViewController.swift
//  Assignment_5
//
//  Created by Omid Azodi on 11/18/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit

var row_chosen = 0

class CourseDetailPageTableViewController: UITableViewController
{
    
    
    @IBAction func back_to_filter_picker(_ sender: Any)
    {
        performSegue(withIdentifier: "back_to_picker_view_filter", sender: self)
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Classes:"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        //print("Course # list")
        //print(num_classes)
        return num_classes
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        print("Cell row in class list is = ")
        print(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "specific_course", for: indexPath)
     
        var title_string = class_subject_list[indexPath.row] + class_course_number_list[indexPath.row] +
            ": "
        if let full_title = class_full_title_list[indexPath.row]
        {
            if (full_title != "")
            {
                title_string = title_string + full_title
            }
        }
        else
        {
            let title_name = class_title_list[indexPath.row]
            if(title_name != "")
            {
                title_string = title_string + title_name
            }
            else
            {
                // no full title or title
                // make it called No-Title
                title_string = title_string + "No-Title"
            }
        }
        
        let start_time =
            class_start_time_list[indexPath.row]
        
        let end_time =
            class_end_time_list[indexPath.row]
        
        var time_string = start_time + " - " + end_time
        
        if (start_time == "" && end_time == "")
        {
            time_string = "No-Time"
        }
        
        let detail_string =
            class_days_list[indexPath.row] +
            ", " + time_string + ", " +
            class_instructor_list[indexPath.row]
            
     
        cell.textLabel?.text       = title_string
        cell.detailTextLabel?.text = detail_string
    
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        row_chosen = indexPath.row
        performSegue(withIdentifier: "add_course_page", sender: self)
    }
}
