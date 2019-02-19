//
//  ViewCoursesTableViewController.swift
//  Assignment_5
//
//  Created by Omid Azodi on 11/25/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit

var course_row_chosen = 0
var waitlist_row_chosen = 0

// to determine whether or not to unregister
// course or unwaitlist course
// so we don't have to make 2 separate scenes
// just one scene, with same functionality
// but behind the scenes different calls
var is_dropping_regular_course = true

class ViewCoursesTableViewController: UITableViewController
{
    
    
    @IBAction func back_to_account_page(_ sender: Any)
    {
        performSegue(withIdentifier:"account_view_page", sender: self)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        course_row_chosen = 0
        waitlist_row_chosen = 0
        is_dropping_regular_course = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (section == 0)
        {
            return "Currently Enrolled:"
        }
        
        return "Waitlisted Courses:"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0)
        {
            // this will be at most 3
            // because a student can only
            // register for at most 3 classes
            return g_courses_added.count
        }
        
        // This to the waitlist
        // array so it can be displayed with the
        // correct amount on the waitlist list
        return g_waitlist_courses_added.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        if (indexPath.section == 0)
        {
            cell.textLabel?.text = g_courses_added[indexPath.row].class_name + "- " +
                g_courses_added[indexPath.row].class_title
        }
        
        if (indexPath.section == 1)
        {
            cell.textLabel?.text = g_waitlist_courses_added[indexPath.row].class_name
            + "- " + g_waitlist_courses_added[indexPath.row].class_title
        }
        
        // do something for waitlist courses
        
        return cell
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath)
    {
        if(indexPath.section == 0)
        {
            course_row_chosen = indexPath.row
            is_dropping_regular_course = true
            performSegue(withIdentifier: "drop_added_course", sender:self)
        }
        
        if(indexPath.section == 1)
        {
            is_dropping_regular_course = false
            waitlist_row_chosen = indexPath.row
            performSegue(withIdentifier: "drop_added_course", sender:self)
        }
    }
}
