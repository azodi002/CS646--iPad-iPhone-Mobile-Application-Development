//
//  SportsViewController.swift
//  Assignment_4_project
//
//  Created by Omid Azodi on 10/28/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

import UIKit
var country_chosen = ""
// keep track of country chosen
// so we can reset list accordingly
var previous_country_selection = ""


class SportsViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource
{
    var countriesArray:[String] = Array()
    var sportsArray:[[String]] = Array()
    
    var usa_sports:[String] =
    ["Baseball", "Football", "Curling",
     "Basketball", "Soccer", "Rock Climbing",
     "Skateboarding"
    ]
    
    var india_sports:[String] =
    ["Cricket", "Chess", "Badminton",
     "Field Hockey", "Football", "Tennis",
     "Gilli-danda", "Golf"
    ]
    
    var taiwan_sports:[String] =
    ["Football", "Archery", "Baseball",
     "Table Tennis", "Cycling", "Taekwondo"
    ]
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if component == 0
        {
            return countriesArray.count
        }
        
        if country_chosen == "India"
        {
            return india_sports.count
        }
        if country_chosen == "USA"
        {
            return usa_sports.count
        }
        else if(country_chosen == "Taiwan")
        {
            return taiwan_sports.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        if component == 0
        {
            country_chosen = countriesArray[row]
            return countriesArray[row]
        }
        
        if country_chosen == "India"
        {
            return india_sports[row]
        }
        
        if country_chosen == "USA"
        {
            return usa_sports[row]
        }
        
        if country_chosen == "Taiwan"
        {
            // ensure we don't go over
            var new_row = 0
            if row >= taiwan_sports.count
            {
                new_row = taiwan_sports.count-1
            }
            else
            {
                new_row = row
            }
            return taiwan_sports[new_row]
        }
    
        return "None:"
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let countrySelected =
            countriesArray[pickerView.selectedRow(inComponent: 0)]
        
        var row_selected = pickerView.selectedRow(inComponent: 1)
        // reset picker
        if previous_country_selection != countrySelected
        {
            self.view.endEditing(false)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.reloadAllComponents();
            // reset row selected
            row_selected = pickerView.selectedRow(inComponent: 1)
        }
        
        var sport_chosen:String = ""
        
        if countrySelected   == "India"
        {
            if row_selected >= india_sports.count
            {
                row_selected =  india_sports.count
            }
            sport_chosen = india_sports[row_selected]
        }
        if countrySelected   == "USA"
        {
            if row_selected >= usa_sports.count
            {
                row_selected = usa_sports.count - 1
            }
            sport_chosen = usa_sports[row_selected]
        }
        if countrySelected   == "Taiwan"
        {
            if row_selected >= taiwan_sports.count
            {
                row_selected = taiwan_sports.count - 1
            }
            sport_chosen = taiwan_sports[row_selected]
        }
        
        
        var message_shown = "Country = "
        message_shown.append(countrySelected)
        message_shown.append(" Sport = ")
        message_shown.append(sport_chosen)
        
        let alert = UIAlertController(title: "Chosen Selections", message: message_shown, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        previous_country_selection = countrySelected
        
    }
    
    
    @IBOutlet weak var country_picker: UIPickerView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // reset pickers
        // when changing between tabs
        // for both componenets
        
        countriesArray.append("India")
        countriesArray.append("USA")
        countriesArray.append("Taiwan")
        
        country_picker.delegate = self
        country_picker.dataSource = self
        
        
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
