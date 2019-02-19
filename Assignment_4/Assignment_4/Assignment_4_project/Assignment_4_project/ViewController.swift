//
//  ViewController.swift
//  Assignment_4_Project
//
//  Created by Omid Azodi on 10/28/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit

// store the name textfield value
// of length greater than 3. Then we can store
// the name_string and it can be used
// in the tab view controller (name tab)
var name_string:String = "None"

/*
extension String {
    var localized: String
    {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
 */

class ViewController: UIViewController
{
    
    @IBOutlet weak var initial_name_label: UILabel!
    
    @IBOutlet weak var initial_pass_label: UILabel!
    
    @IBOutlet weak var initial_name_text: UITextField!
    
    
    @IBOutlet weak var initial_pass_text: UITextField!
    
    
    @IBOutlet weak var initial_state_button: UIButton!
    
    
    @IBOutlet weak var initial_tab_button: UIButton!
    
    
    @IBAction func state_button_clicked(_ sender: Any)
    {
        if(button_requirement_met())
        {
            performSegue(withIdentifier: "StateSegue", sender: self)
        }
    }
    
    @IBAction func tab_button_clicked(_ sender: Any)
    {
        if(button_requirement_met())
        {
            performSegue(withIdentifier: "TabSegue", sender: self)
        }
    }
    
    
    func button_requirement_met()->Bool
    {
        // name and pass text fields
        // must have greater than 3 length
        var requirements_met:Bool = false;
        
        if let name_text = initial_name_text
        {
            if let name_text_value = name_text.text
            {
                name_string = name_text_value
                if name_text_value.count > 3
                {
                    // then continue on with
                    // checking password length
                    // being greater than 3
                    if let pass_text = initial_pass_text
                    {
                        if let pass_text_value = pass_text.text
                        {
                            if pass_text_value.count > 3
                            {
                                requirements_met = true
                            }
                        }
                    }
                }
            }
        }
        return requirements_met
    } // button_requirement_met
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // assign if anything was changed from the
        // name tab view
        // localize for SPANISH AND ENGLISH
        initial_name_text.text = name_tab_string
        initial_name_label.text =
            NSLocalizedString("Name_Label", comment: "")
        
        initial_pass_label.text = NSLocalizedString("Password_Label", comment: "")
        initial_state_button.setTitle(NSLocalizedString("State_Label", comment: ""), for: .normal)
        
        initial_tab_button.setTitle(NSLocalizedString("Tab_Label", comment: ""), for: .normal)
    }
    
}

