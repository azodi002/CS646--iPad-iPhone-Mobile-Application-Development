//
//  AddClassViewController.swift
//  Assignment_5
//
//  Created by Omid Azodi on 11/25/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit
import Alamofire

struct AddedCourses
{
    var class_name: String
    var class_id: Int
    var class_title: String
    var class_extra_info: String
}

var g_courses_added = [AddedCourses]()
var g_waitlist_courses_added = [AddedCourses]()

class AddClassViewController: UIViewController

{
    
    @IBOutlet weak var class_name: UILabel!
    
    
    @IBOutlet weak var course_description: UITextView!
    @IBOutlet weak var pre_req: UITextView!
    
    @IBOutlet weak var back_to_filter: UIButton!
    
    @IBAction func filter_page(_ sender: Any)
    {
        performSegue(withIdentifier: "back_to_filtered_page", sender: self)
    }
    
    @IBAction func add_course(_ sender: Any)
    {
        // we want to check if we should
        // add the class for the student
        // or waitlist the class for the student
        // we do that by checking if enrolled == seats
        // available
        
        // we also don't want to add a class
        // that has already been added
        // so check for that before trying to
        // make the call
        
        var is_course_already_added = false
        
        for course in g_courses_added
        {
            if(course.class_id == class_id_list[row_chosen])
            {
                is_course_already_added = true
            }
        }
        
        for wait_course in g_waitlist_courses_added
        {
            if(wait_course.class_id  == class_id_list[row_chosen])
            {
                is_course_already_added = true
            }
        }
        
        // only attempt to add course
        // if wasn't previously added to waitlist
        // or actually registered, to prevent duplicates
        if(is_course_already_added == false)
        {
            if (class_enrolled_list[row_chosen] == class_seats_list[row_chosen])
            {
                createWaitlistURL()
            }
            else
            {
                createRegisterClassURL()
            }
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        class_name.text =
            class_subject_list[row_chosen] + ":" +
            class_course_number_list[row_chosen]
        
        course_description.text =
            class_description_list[row_chosen]
        
        pre_req.text =
            class_pre_req_list[row_chosen]
        
        // Do any additional setup after loading the view.
    }
    
    func createRegisterClassURL() -> Void
    {
        let default_string = "https://bismarck.sdsu.edu/registration/registerclass?redid={REDID}&password={PASSWORD}&courseid={COURSEID}"
        
        var final_url =
            default_string.replacingOccurrences(
                of: "{REDID}",
                with: user_red_id,
                options: NSString.CompareOptions.literal,
                range:nil)
        
        final_url =
            final_url.replacingOccurrences(
                of: "{PASSWORD}",
                with: user_password,
                options: NSString.CompareOptions.literal,
                range:nil)
        
        final_url =
            final_url.replacingOccurrences(
                of: "{COURSEID}",
                with: String(class_id_list[row_chosen]),
                options: NSString.CompareOptions.literal,
                range:nil)

        print(final_url)
        
        Alamofire.request(final_url).validate().responseJSON()
        {
                response in
                
                print(response)
                switch response.result
                {
                case .success:
                    do
                    {
                        print("Succesfully added class")
                        // add to array g_courses_added
                        // so we can show on another screen
                        // for view courses (This should be at most 3)
                        // and only added if succesful
                        if(g_courses_added.count < 3)
                        {
                            var class_full_title = ""
                            if let c_title = class_full_title_list[row_chosen]
                            {
                                class_full_title = c_title as! String
                            }
                            
                            var c_extra_info =
                                "Instructor: " + class_instructor_list[row_chosen] + " \n" +
                                "Start Time: " + class_start_time_list[row_chosen]  + " \n" +
                                "End Time:" + class_end_time_list[row_chosen] + " \n" +
                                "Days Meet:" + class_days_list[row_chosen]
                            
                            let course_added =
                                AddedCourses(class_name:  self.class_name.text!, class_id: class_id_list[row_chosen],class_title:class_full_title,
                                             class_extra_info:c_extra_info )
                            let alert =
                                UIAlertController(
                                    title: "Added course:",
                                    message: "You have succesfully added the course.",
                                    preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                            g_courses_added.append(course_added)
                        }
                        else
                        {
                            let alert =
                                UIAlertController(
                                    title: "Course Not Added:",
                                    message: "Cannot add more than 3 courses",
                                    preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    }
                case .failure(_):
                    do
                    {
                        let alert =
                            UIAlertController(
                                title: "Course Not Added:",
                                message: "Unable to add course",
                                preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        
                    }
                } //  switch response.result
                
        } // Alamofire.request(final_url).validate().responseJSON()
    }
    
    func createWaitlistURL() -> Void
    {
        let default_string = "https://bismarck.sdsu.edu/registration/waitlistclass?redid={REDID}&password={PASSWORD}&courseid={COURSEID}"
        
        var final_url =
            default_string.replacingOccurrences(
                of: "{REDID}",
                with: user_red_id,
                options: NSString.CompareOptions.literal,
                range:nil)
        
        final_url =
            final_url.replacingOccurrences(
                of: "{PASSWORD}",
                with: user_password,
                options: NSString.CompareOptions.literal,
                range:nil)
        
        final_url =
            final_url.replacingOccurrences(
                of: "{COURSEID}",
                with: String(class_id_list[row_chosen]),
                options: NSString.CompareOptions.literal,
                range:nil)
        
        print(final_url)
        
        Alamofire.request(final_url).validate().responseJSON()
            {
                response in
                
                print(response)
                switch response.result
                {
                case .success:
                    do
                    {
                        var class_full_title = ""
                        if let c_title = class_full_title_list[row_chosen]
                        {
                            class_full_title = c_title as! String
                        }
                        print("Succesfully waitlisted class")
                        
                        var c_extra_info =
                            "Instructor: " + class_instructor_list[row_chosen] + " \n" +
                                "Start Time: " + class_start_time_list[row_chosen]  + " \n" +
                                "End Time:" + class_end_time_list[row_chosen] + " \n" +
                                "Days Meet:" + class_days_list[row_chosen]
                        let course_added =
                            AddedCourses(class_name:  self.class_name.text!, class_id: class_id_list[row_chosen],
                                         class_title:class_full_title,
                                         class_extra_info:c_extra_info)
                        
                        let alert =
                            UIAlertController(
                                title: "Waitlist course added:",
                                message: "Succesfully added course to waitlist",
                                preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        
                        g_waitlist_courses_added.append(course_added)
                    }
                case .failure(_):
                    do
                    {
                        let alert =
                            UIAlertController(
                                title: "Course Not Added:",
                                message: "Unable to add course to waitlist or enrolled",
                                preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                } //  switch response.result
                
        } // Alamofire.request(final_url).validate().responseJSON()
    }

}
