//
//  ViewController.swift
//  Assignment_5
//
//  Created by Omid Azodi on 11/11/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit
import Alamofire


// I chose to go with global arrays
// because passing them through performSegue
// calls could lead in performance loss
// this way regardless how big the array is
// we reference one location and access
// all the data, rather than create a copy
// when passing it to a function
// or passing it through a reference still has
// some overhead. To me this seems a little more
// easier for readability as well
var g_title_array       = [String]()
var g_id_array          = [Int]()
var g_college_array     = [String]()
var g_num_classes_array = [Int]()

var g_first_name = String()
var g_last_name  = String()
var g_red_id     = String()
var g_email      = String()

// used to register a course
var user_password:String = ""
var user_red_id:String = ""


class ViewController: UIViewController
{
    @IBOutlet weak var first_name_text_field: UITextField!
    @IBOutlet weak var last_name_text_field: UITextField!
    @IBOutlet weak var sdsu_name_text_field: UITextField!
    @IBOutlet weak var email_text_field: UITextField!
    @IBOutlet weak var password_text_field: UITextField!
    
    // ------------------------------------------------

    @IBAction func RegisterNewStudent(_ sender: Any)
    {
        if (validArguments())
        {
            createAddStudentURL(from_login_button:false)
        }
    }
    // ------------------------------------------------

    func createSubjectListURL() -> Void
    {
        // in this case there are no url parameters
        // so the default string is essentially
        // our final string to use as the request to be sent
        let default_string = "https://bismarck.sdsu.edu/registration/subjectlist"
        
        Alamofire.request(default_string).validate().responseJSON
        {
           response in
            
            // check if result was succesfull
            // then fill in the global arrays
            // if it is
            // otherwise just clear them out
            switch response.result
            {
                case .success:
                    do
                    {
                        for anItem in response.result.value as! [Dictionary<String, AnyObject>]
                        {
                            let class_title      = anItem["title"] as! String
                            let class_id         = anItem["id"] as! Int
                            let class_college    = anItem["college"] as! String
                            let class_num_clases = anItem["classes"] as! Int
                            
                            g_title_array.append(class_title)
                            g_id_array.append(class_id)
                            g_college_array.append(class_college)
                            g_num_classes_array.append(class_num_clases)
                        }
                    }// do
            case .failure(_):
                do
                {
                    g_title_array.removeAll()
                    g_id_array.removeAll()
                    g_college_array.removeAll()
                    g_num_classes_array.removeAll()
                } //do
            } // switch response.result
        } //  Alamofire.request(default_string).validate().responseJSON
    } // func createSubjectListURL() -> Void
 
    // ------------------------------------------------

    // passing in a bool for login_button
    // because we want to parse the response
    // differently for login button
    // because if the user is logging in, with their
    // info, then we get a response of red id already in use
    // and that is good, because that means the user
    // is created and we are logging in, and should not
    // treat that as an error, but for the register new user
    // scenario we want to treat that response as an error
    func createAddStudentURL(from_login_button: Bool) -> Void
    {
        // set up the string with required parameters set in
        // and replace the fields after we call validArguments()
        let default_string =
        "https://bismarck.sdsu.edu/registration/addstudent?firstname={FirstName}&lastname={LastName}&redid={RedID}&password={Password}&email={Email}"
        
        var final_url =
            default_string.replacingOccurrences(
                of: "{FirstName}",
                with: first_name_text_field.text!,
                options: NSString.CompareOptions.literal,
                range:nil)
        
        final_url =
            final_url.replacingOccurrences(
                of: "{LastName}",
                with: last_name_text_field.text!,
                options: NSString.CompareOptions.literal,
                range:nil)
        
        final_url =
            final_url.replacingOccurrences(
                of: "{RedID}",
                with: sdsu_name_text_field.text!,
                options: NSString.CompareOptions.literal,
                range:nil)
        
        final_url =
            final_url.replacingOccurrences(
                of: "{Password}",
                with: password_text_field.text!,
                options: NSString.CompareOptions.literal,
                range:nil)
        
        final_url =
            final_url.replacingOccurrences(
                of: "{Email}",
                with: email_text_field.text!,
                options: NSString.CompareOptions.literal,
                range:nil)
        
        if let u_pass = password_text_field.text
        {
            user_password = u_pass
        }
        
        if let r_id = sdsu_name_text_field.text
        {
            user_red_id = r_id
        }
            // from register button
            Alamofire.request(final_url).validate()
                
                .responseString
                {
                    response in switch response.result
                    {
                    case .success(let error):
                        do
                        {
                            if(!error.contains("in use") &&
                               !error.contains("email no"))
                            {
                            //print(utf8Text)
                            DispatchQueue.main.async()
                            {
                                // if succesfully register for student
                                // then call the subjectlist request
                                // to create the arrays necessary
                                // to fill the table in the account_segue
                                // view
                                self.createSubjectListURL()
                                self.performSegue(withIdentifier: "account_segue", sender: self)
                            }
                            }
                            else
                            {
                                if(error.contains("in use"))
                                {
                                let alert =
                                    UIAlertController(
                                        title: "Register:",
                                        message: "Unable to register as student, REDID IN USE",
                                        preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                     self.present(alert, animated: true)
                                }
                                if(error.contains("email no"))
                                {
                                    let alert =
                                        UIAlertController(
                                            title: "Register:",
                                            message: "Unable to register as student, Email has no @",
                                            preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                     self.present(alert, animated: true)
                                }
                            }
                        }
                    case .failure(_):
                        
                        do
                        {
                            let alert =
                                UIAlertController(
                                    title: "Register:",
                                    message: "Unable to register as student",
                                    preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    }
                }
    } // func createAddStudentURL() -> Void
    
// ------------------------------------------------

    // add some validation that server
    // doesn't do for us, on the client side
    // before making the request
    // otherwise we will display an alert
    // to the user that there
    // are invalid requirements
    func validArguments() -> Bool
    {
        var are_all_arguments_valid:Bool = true
        
        if let first_text_value = first_name_text_field.text
        {
            if(first_text_value.isEmpty)
            {
                // assume if it is not
                // empty then it is good
                // otherwise bad
                let alert =
                    UIAlertController(
                        title: "Student Not Added:",
                        message: "First name was empty",
                        preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                are_all_arguments_valid = false
            }
             g_first_name = first_text_value
        } // if let first_text_value = first_name_text_field.text
        
        if let last_text_value = last_name_text_field.text
        {
            if(last_text_value.isEmpty)
            {
                // assume if it is not
                // empty then it is good
                // otherwise bad
                let alert =
                    UIAlertController(
                        title: "Student Not Added:",
                        message: "Last name was empty",
                        preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                are_all_arguments_valid = false
            }
            g_last_name = last_text_value
        } // if let last_text_value = first_name_text_field.text
        
        if let pass_text_value = password_text_field.text
        {
            // if nothing was entered then false
            if(pass_text_value.isEmpty)
            {
                let alert =
                    UIAlertController(
                        title: "Student Not Added:",
                        message: "Password was empty",
                        preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                are_all_arguments_valid = false
            }
            
            // although server sends error response
            // if password length not reached
            // but i'll handle this on the client
            // side, as it will save significant
            // amount of time to display the error
            // instead of sending and parsing response
            else if(pass_text_value.count < 8)
            {
                are_all_arguments_valid = false
                let alert =
                    UIAlertController(
                        title: "Student Not Added:",
                        message: "Password was not 8 chars. long",
                        preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            // the server doesn't check if
            // there is at least 7 unique
            // characters in the password field
            // so we check that here
            else
            {
                let number_of_distinct = Set(pass_text_value).count
                if(number_of_distinct < 7)
                {
                    are_all_arguments_valid = false
                    let alert =
                        UIAlertController(
                            title: "Student Not Added:",
                            message: "Password doesn't have at least 7 distinct characters",
                            preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        } // if let pass_text_value = password_text_field.text
        
        // redid must be 9 characters long
        if let sdsu_red_id = sdsu_name_text_field.text
        {
            if(sdsu_red_id.count != 9)
            {
                let alert =
                    UIAlertController(
                        title: "Student Not Added:",
                        message: "Red ID was not 9 chars. long",
                        preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                are_all_arguments_valid = false
            }
            g_red_id = sdsu_red_id
        } //  if let sdsu_red_id = sdsu_name_text_field.text
        
        if let email_text = email_text_field.text
        {
            if(!email_text.contains("@"))
            {
                // if email doesn't contain an @
                are_all_arguments_valid = false
                let alert =
                    UIAlertController(
                        title: "Student Not Added:",
                        message: "email did not contain @ symbol",
                        preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            g_email = email_text
        } // if let email_text = email_text_field.text
        
        return are_all_arguments_valid
    } // func validArguments()
    
// ------------------------------------------------

    
    override func viewDidLoad()
    {
    
        super.viewDidLoad()
        g_courses_added.removeAll()
        g_waitlist_courses_added.removeAll()
        
    }

// ------------------------------------------------


}

