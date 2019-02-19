//
//  DropAddedCoursesViewController.swift
//  Assignment_5
//
//  Created by Omid Azodi on 11/26/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit
import Alamofire

class DropAddedCoursesViewController: UIViewController
{
    @IBOutlet weak var course_name: UITextView!
    
    
    @IBAction func drop_course_button(_ sender: Any)
    {
        if(is_dropping_regular_course == true)
        {
            createUnRegisterURL()
        }
        else
        {
            createUnwaitlistURL()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if(is_dropping_regular_course == true)
        {
            course_name.text =
                g_courses_added[course_row_chosen].class_name + "- " +
                g_courses_added[course_row_chosen].class_title + "\n" +
                g_courses_added[course_row_chosen].class_extra_info
   
        }
        else
        {
            course_name.text =
                g_waitlist_courses_added[waitlist_row_chosen].class_name + "- " +
                g_waitlist_courses_added[waitlist_row_chosen].class_title + "\n" +
                g_waitlist_courses_added[waitlist_row_chosen].class_extra_info
            
            
        }
    }
    
    func createUnRegisterURL() -> Void
    {
        let default_string = "https://bismarck.sdsu.edu/registration/unregisterclass?redid={REDID}&password={PASSWORD}&courseid={COURSEID}"
        
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
                with: String(g_courses_added[course_row_chosen].class_id),
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
                        g_courses_added.remove(at:course_row_chosen)
                        DispatchQueue.main.async()
                        {
                         self.performSegue(withIdentifier: "go_back_to_view_course", sender: self)
                        }
                    }
                case .failure(_):
                    do
                    {
                        let alert =
                            UIAlertController(
                                title: "Course Not Dropped:",
                                message: "Unable to drop course",
                                preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        print("Unable to drop class")
                    }
                } //  switch response.result
        } // Alamofire.request(final_url).validate().responseJSON()
    } //  func createUnRegisterURL() -> Void
    
    
    func createUnwaitlistURL() -> Void
    {
        let default_string = "https://bismarck.sdsu.edu/registration/unwaitlistclass?redid={REDID}&password={PASSWORD}&courseid={COURSEID}"
        
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
                with: String(g_waitlist_courses_added[waitlist_row_chosen].class_id),
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
                        print("Succesfully dropped waitlisted class")
                        g_waitlist_courses_added.remove(at:course_row_chosen)
                        DispatchQueue.main.async()
                        {
                            self.performSegue(withIdentifier: "go_back_to_view_course", sender: self)
                        }
                    }
                case .failure(_):
                    do
                    {
                        let alert =
                            UIAlertController(
                                title: "Waitlisted Course Not Dropped:",
                                message: "Unable to drop waitlisted course",
                                preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                } //  switch response.result
        } // Alamofire.request(final_url).validate().responseJSON()
    } //  func createUnRegisterURL() -> Void
}
