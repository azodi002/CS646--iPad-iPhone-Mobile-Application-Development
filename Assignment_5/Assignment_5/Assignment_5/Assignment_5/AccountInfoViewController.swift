//
//  AccountInfoViewController.swift
//  Assignment_5
//
//  Created by Omid Azodi on 11/16/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit

class AccountInfoViewController: UIViewController
{
    
    
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var redid_label: UILabel!
    @IBOutlet weak var email_label: UILabel!
    
    
    @IBOutlet weak var back_login_screen: UIButton!
    
    @IBAction func login_screen(_ sender: Any)
    {
        performSegue(withIdentifier: "back_to_login", sender: self)
    }
    
    @IBAction func view_courses(_ sender: Any)
    {
        performSegue(withIdentifier: "view_courses", sender: self)
    }
    
    
    @IBAction func add_course(_ sender: Any)
    {
        performSegue(withIdentifier: "ViewMajor", sender: self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        name_label.text  = g_first_name + g_last_name
        redid_label.text = g_red_id
        email_label.text = g_email

        // Do any additional setup after loading the view.
    }
}
