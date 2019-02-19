//
//  ClassFilterViewController.swift
//  Assignment_5
//
//  Created by Omid Azodi on 11/25/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit
import Alamofire

var class_subject_list       = [String]()
var class_course_number_list = [String]()
var class_full_title_list    = [String?]()
var class_days_list          = [String]()
var class_instructor_list    = [String]()
var class_start_time_list    = [String]()
var class_end_time_list      = [String]()
var class_description_list   = [String]()

var class_pre_req_list       = [String]()

var class_waitlist_list      = [Int]()
var class_enrolled_list      = [Int]()
var class_seats_list         = [Int]()


var start_time_data =
[
    "None",
    "00:15",
    "00:30",
    "00:45",
    "01:00",
    "01:15",
    "01:30",
    "01:45",
    "02:00",
    "02:15",
    "02:30",
    "02:45",
    "03:00",
    "03:15",
    "03:30",
    "03:45",
    "04:00",
    "04:15",
    "04:30",
    "04:45",
    "05:00",
    "05:15",
    "05:30",
    "05:45",
    "06:00",
    "06:15",
    "06:30",
    "06:45",
    "07:00",
    "07:15",
    "07:30",
    "07:45",
    "08:00",
    "08:15",
    "08:30",
    "08:45",
    "09:00",
    "09:15",
    "09:30",
    "09:45",
    "10:00",
    "10:15",
    "10:30",
    "10:45",
    "11:00",
    "11:15",
    "11:30",
    "11:45",
    "12:00",
    "12:15",
    "12:30",
    "12:45",
    "13:00",
    "13:15",
    "13:30",
    "13:45",
    "14:00",
    "14:15",
    "14:30",
    "14:45",
    "15:00",
    "15:15",
    "15:30",
    "15:45",
    "16:00",
    "16:15",
    "16:30",
    "16:45",
    "17:00",
    "17:15",
    "17:30",
    "17:45",
    "18:00",
    "18:15",
    "18:30",
    "18:45",
    "19:00",
    "19:15",
    "19:30",
    "19:45",
    "20:00",
    "20:15",
    "20:30",
    "20:45",
    "21:00",
    "21:15",
    "21:30",
    "21:45",
    "22:00",
    "22:15",
    "22:30",
    "22:45",
    "23:00",
    "23:15",
    "23:30",
    "23:45"
]

var end_time_data =
[
        "None",
        "00:15",
        "00:30",
        "00:45",
        "01:00",
        "01:15",
        "01:30",
        "01:45",
        "02:00",
        "02:15",
        "02:30",
        "02:45",
        "03:00",
        "03:15",
        "03:30",
        "03:45",
        "04:00",
        "04:15",
        "04:30",
        "04:45",
        "05:00",
        "05:15",
        "05:30",
        "05:45",
        "06:00",
        "06:15",
        "06:30",
        "06:45",
        "07:00",
        "07:15",
        "07:30",
        "07:45",
        "08:00",
        "08:15",
        "08:30",
        "08:45",
        "09:00",
        "09:15",
        "09:30",
        "09:45",
        "10:00",
        "10:15",
        "10:30",
        "10:45",
        "11:00",
        "11:15",
        "11:30",
        "11:45",
        "12:00",
        "12:15",
        "12:30",
        "12:45",
        "13:00",
        "13:15",
        "13:30",
        "13:45",
        "14:00",
        "14:15",
        "14:30",
        "14:45",
        "15:00",
        "15:15",
        "15:30",
        "15:45",
        "16:00",
        "16:15",
        "16:30",
        "16:45",
        "17:00",
        "17:15",
        "17:30",
        "17:45",
        "18:00",
        "18:15",
        "18:30",
        "18:45",
        "19:00",
        "19:15",
        "19:30",
        "19:45",
        "20:00",
        "20:15",
        "20:30",
        "20:45",
        "21:00",
        "21:15",
        "21:30",
        "21:45",
        "22:00",
        "22:15",
        "22:30",
        "22:45",
        "23:00",
        "23:15",
        "23:30",
        "23:45"
]

var level_data = ["None", "lower", "upper", "graduate"]

var start_time_value = "None"
var end_time_value = "None"
var level_value = "None"

class ClassFilterViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource
{    
    
    @IBOutlet weak var data_picker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
       if (component == 0)
       {
            return start_time_data.count
       }
       if (component == 1)
       {
            return end_time_data.count
       }
        // level componenet == 2
        return level_data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if (component == 0)
        {
            return start_time_data[row]
        }
        else if (component == 1)
        {
            return end_time_data[row]
        }
        
        return level_data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (component == 0)
        {
            start_time_value = start_time_data[row]
        }
        
        else if (component == 1)
        {
            end_time_value = end_time_data[row]
        }
        
        else
        {
            level_value = level_data[row]
        }
    }
    
    @IBOutlet weak var class_name: UILabel!
    
    
    @IBAction func go_back_to_course_list(_ sender: Any)
    {
        performSegue(withIdentifier: "back_to_courses", sender: self)
        
    }
    
    @IBAction func search_with_filter(_ sender: Any)
    {
        createFilterDetailList()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        class_name.text = course_filter_name
        self.data_picker.delegate = self
        self.data_picker.dataSource = self

        class_subject_list.removeAll()
        class_course_number_list.removeAll()
        class_full_title_list.removeAll()
        class_days_list.removeAll()
        class_instructor_list.removeAll()
        class_start_time_list.removeAll()
        class_end_time_list.removeAll()
        class_description_list.removeAll()
        class_pre_req_list.removeAll()
        class_id_list.removeAll()
        
        class_waitlist_list.removeAll()
        class_enrolled_list.removeAll()
        class_seats_list.removeAll()

        
        num_classes = 0
        
        start_time_value = "None"
        end_time_value = "None"
        level_value = "None"
        

        // Do any additional setup after loading the view.
    }
    
    
    func createFilterDetailList() -> Void
    {
            // when no filter is selected
            /*let default_string =
            "https://bismarck.sdsu.edu/registration/classdetails?classid={ClassID}"
            */
            
            var default_string = "https://bismarck.sdsu.edu/registration/classidslist?subjectid={ClassID}"
        
            if (start_time_value != "None")
            {
                default_string.append("&starttime={START}")
            }
        
            if (end_time_value != "None")
            {
                default_string.append("&endtime={END}")
            }
        
            if (level_value != "None")
            {
                default_string.append("&level={LEVEL}")
            }
            
            var final_url =
                default_string.replacingOccurrences(
                    of: "{ClassID}",
                    with: String(top_level_course_id),
                    options: NSString.CompareOptions.literal,
                    range:nil)
        
            final_url =
                final_url.replacingOccurrences(
                    of: "{START}",
                    with: start_time_value,
                    options: NSString.CompareOptions.literal,
                    range:nil)
        
            final_url =
                final_url.replacingOccurrences(
                    of: "{END}",
                    with: end_time_value,
                    options: NSString.CompareOptions.literal,
                    range:nil)
        
            final_url =
                final_url.replacingOccurrences(
                    of: "{LEVEL}",
                    with: level_value,
                    options: NSString.CompareOptions.literal,
                    range:nil)
        
        print("Final URL = ", final_url)
        
        Alamofire.request(final_url).validate().responseJSON()
        {
                response in
                
                print(response)
                switch response.result
                {
                    case .success:
                    do
                    {
                        for anItem in response.result.value as! [Int]
                        {
                            class_id_list.append(anItem)
                        }
                        
                        // attempt to retrieve
                        // the class details for each course
                        self.createClassDetailURL()
                    }
                case .failure(_):
                    do
                    {
                        class_id_list.removeAll()
                        class_subject_list.removeAll()
                        class_course_number_list.removeAll()
                        class_full_title_list.removeAll()
                        class_days_list.removeAll()
                        class_instructor_list.removeAll()
                        class_start_time_list.removeAll()
                        class_end_time_list.removeAll()
                        class_description_list.removeAll()
                        class_pre_req_list.removeAll()
                        class_waitlist_list.removeAll()
                        class_enrolled_list.removeAll()
                        class_seats_list.removeAll()
                        let alert =
                            UIAlertController(
                                title: "Courses:",
                                message: "Unable to get courses",
                                preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
            } //  switch response.result
            
        } // Alamofire.request(final_url).validate().responseJSON()
                    
    } // func createClassDetailURL() -> Void
    
    func createClassDetailURL() -> Void
    {
        //print("inside class detail")
        //print(class_id_list.count)
        //num_classes = class_id_list.count
        for course_id in class_id_list
        {
            let default_string =
            "https://bismarck.sdsu.edu/registration/classdetails?classid={ClassID}"
            
            let final_url =
                default_string.replacingOccurrences(
                    of: "{ClassID}",
                    with: String(course_id),
                    options: NSString.CompareOptions.literal,
                    range:nil)
            
            //print(final_url)
            
            Alamofire.request(final_url).validate().responseJSON()
                {
                    response in
                    
                    print(response)
                    switch response.result
                    {
                    case .success:
                        do
                        {
                            print("Success detail")
                            let course_detail = response.result.value
                            
                            var course_detail_dict =
                                course_detail as! Dictionary<String, Any>
                            
                            var full_title = ""
                            if let f_title = course_detail_dict["fullTitle"]
                            {
                                full_title = f_title as! String
                            }
                            
                            var course_number = ""
                            if let c_number = course_detail_dict["course#"]
                            {
                                course_number = c_number as! String
                            }
                            
                            var subject_name = ""
                            if let s_name  = course_detail_dict["subject"]
                            {
                                subject_name = s_name as! String
                            }
                            
                            var instructor_name:String = ""
                            if let inst_name = course_detail_dict["instructor"]
                            {
                                instructor_name = inst_name as! String
                            }
                            else
                            {
                                instructor_name = "No-Instructor"
                            }
                            
                            var days_meet = ""
                            if let d_meet = course_detail_dict["days"]
                            {
                                days_meet = d_meet as! String
                            }
                            
                            var start_time = ""
                            if let s_time = course_detail_dict["startTime"]
                            {
                                start_time = s_time as! String
                            }
                            
                            var end_time = ""
                            if let e_time   = course_detail_dict["endTime"]
                            {
                                end_time = e_time as! String
                            }
                            
                            var title_name = ""
                            if let t_name = course_detail_dict["title"]
                            {
                                title_name = t_name as! String
                            }
                            
                            var class_description = ""
                            if let c_description = course_detail_dict["description"]
                            {
                                class_description = c_description as! String
                            }
                            
                            var class_pre_req = ""
                            if let c_pre_req = course_detail_dict["prerequisite"]
                            {
                                class_pre_req = c_pre_req as! String
                            }
                            
                            var waitlist_num = 0
                            if let w_num = course_detail_dict["waitlist"]
                            {
                                waitlist_num = w_num as! Int
                            }
                            
                            var enroll_num = 0
                            if let e_num = course_detail_dict["enrolled"]
                            {
                                enroll_num = e_num as! Int
                            }
                            
                            var seat_num = 0
                            if let s_num = course_detail_dict["seats"]
                            {
                                seat_num = s_num as! Int
                            }
                            
                            
                            class_waitlist_list.append(waitlist_num)
                            class_enrolled_list.append(enroll_num)
                            class_seats_list.append(seat_num)
                            
                            class_pre_req_list.append(class_pre_req)
                            class_subject_list.append(subject_name)
                            class_course_number_list.append(course_number)
                            class_full_title_list.append(full_title)
                            
                            class_days_list.append(days_meet)
                            class_instructor_list.append(instructor_name)
                            class_start_time_list.append(start_time)
                            class_end_time_list.append(end_time)
                            class_title_list.append(title_name)
                            class_description_list.append(class_description)
                            
                            
                            num_classes = num_classes + 1
                            print(num_classes)
                            DispatchQueue.main.async()
                            {
                                    if(num_classes == class_id_list.count)
                                    {
                                        print("HIT IT!")
                                        self.performSegue(withIdentifier: "Courses_Page", sender: self)
                                    }
                            }
                        } // do for success
                        
                    case.failure(_):
                        do
                        {
                            print("Failure for course detail")
                            class_subject_list.removeAll()
                            class_course_number_list.removeAll()
                            class_full_title_list.removeAll()
                            class_days_list.removeAll()
                            class_instructor_list.removeAll()
                            class_start_time_list.removeAll()
                            class_end_time_list.removeAll()
                            class_description_list.removeAll()
                            class_pre_req_list.removeAll()
                            class_id_list.removeAll()
                            class_waitlist_list.removeAll()
                            class_enrolled_list.removeAll()
                            class_seats_list.removeAll()
                            num_classes = 0
                        } // do failure
                    } // switch response.result
            } // Alamofire.request(final_url).validate().responseJSON()
            
        } // for course_id in class_id_list
    } // func createClassDetailURL() -> Void
    
}
