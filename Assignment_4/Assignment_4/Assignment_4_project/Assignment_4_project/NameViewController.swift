//
//  NameViewController.swift
//  Assignment_4_project
//
//  Created by Omid Azodi on 10/28/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit

// we set name_tab_string to the value
// that is assigned to it when the user
// clicks Back and takes to home screen
// so we can compare to the initial screen
// value and if it wasn't changed then we keep as is
// otherwise we go ahead and assign it to the initial screen
// name page
var name_tab_string:String = ""

class NameViewController: UIViewController
{

    @IBOutlet weak var name_tab_name_label: UILabel!
    
    @IBOutlet weak var name_tab_name_text: UITextField!
    
    
    
    @IBAction func back_button_pressed(_ sender: Any)
    {
        // at this point the user could have enetered
        // anything from the name tab so we go ahead
        // and store the value entered when clicking
        // the back button
        if let name_tab_text = name_tab_name_text
        {
            if let name_tab_text_value = name_tab_text.text
            {
                // unwrapped safely so we don't worry about it
                // in initial scene, also initialized to ""
                // so we can tell if it was changed or not as well
                name_tab_string = name_tab_text_value
            }
        }
    }
    
    
    
    override func viewDidLoad()
    {

        // the value will already be unwrapped and checked
        // because we can only access this field if the
        // required length is met of more than 3
        // so we can go ahead and assign it
        // Note: name_string is set from the initial string
        name_tab_name_text.text = name_string
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
