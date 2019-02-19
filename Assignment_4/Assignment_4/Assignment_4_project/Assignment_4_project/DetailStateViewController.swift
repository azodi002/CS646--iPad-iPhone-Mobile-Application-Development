//
//  DetailStateViewController.swift
//  Assignment_4_project
//
//  Created by Omid Azodi on 10/28/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit

class DetailStateViewController: UIViewController {

    
    
    
    @IBOutlet weak var detail_state_name: UILabel!
    
    @IBOutlet weak var detail_state_ab: UILabel!
    
    
    @IBOutlet weak var detail_state_capital: UILabel!
    
    
    @IBOutlet weak var detail_state_date: UILabel!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        detail_state_name.text = table_rows[my_index]
        detail_state_ab.text = state_abbreviation[my_index]
        detail_state_capital.text = state_capital[my_index]
        detail_state_date.text = state_date[my_index]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
