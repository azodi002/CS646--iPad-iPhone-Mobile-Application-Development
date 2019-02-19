//
//  ViewController.swift
//  Color Viewer
//
//  Created by Omid Azodi on 9/20/18.
//  Copyright © 2018 Omid Azodi. All rights reserved.
//

/******************
 Name: Omid Azodi
 Professor: Dr. Whitney
 Assignment: Assignment # 2
 Due Date: 09/21/2018
 Course: CS646 (iOS in class)
 
 Assignment Goals:
     - Introduction to iOS apps and related issues:
     - Keyboard - hiding and selecting
     - Dealing with text fields and buttons
     - Saving data
     - Using sliders
 ******************/

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var RedTextField:   UITextField!
    @IBOutlet weak var GreenTextField: UITextField!
    @IBOutlet weak var BlueTextField:  UITextField!
    
    @IBOutlet weak var RedLabel:   UILabel!
    @IBOutlet weak var GreenLabel: UILabel!
    @IBOutlet weak var BlueLabel:  UILabel!

    @IBOutlet weak var RedColorSlider:   UISlider!
    @IBOutlet weak var GreenColorSlider: UISlider!
    @IBOutlet weak var BlueColorSlider:  UISlider!
    
    @IBOutlet weak var ColorView:  UIView!
    
    
    @IBOutlet var ColorViewPanGestureRecognizer: UIPanGestureRecognizer!
   
    @IBAction func ColorViewPanGestureRecognizerAction(_ sender: UIPanGestureRecognizer)
    {
        var offset_move = sender.translation(in: ColorView)
        var sender_view = sender.view!
        var center_view_x = sender_view.center.x
        var center_view_y = sender_view.center.y
        sender_view.center =
            CGPoint(x:center_view_x + offset_move.x,
                    y:center_view_y + offset_move.y)
        sender.setTranslation(CGPoint.zero, in:self.view)
        
    }
    
    
    
    
   // -----------------------------------------------------------------
    @IBAction func RedTextFieldValueChangedAfterEditingEnded(_ sender: Any)
    {
        RedColorSlider.value = Float(RedTextField.text!)!
    }
    
    // -----------------------------------------------------------------
    @IBAction func GreenTextFieldValueChangedAfterEditingEnded(_ sender: Any)
    {
        GreenColorSlider.value = Float(GreenTextField.text!)!
    }
    
    // -----------------------------------------------------------------
    @IBAction func BlueTextFieldValueChangedAfterEditingEnded(_ sender: Any)
    {
        BlueColorSlider.value = Float(BlueTextField.text!)!
    }
    
    // -----------------------------------------------------------------
    @IBAction func RedSliderValueChanged(_ sender: Any)
    {
        RedTextField.text = String(Int(RedColorSlider.value))
        // after adjusting text field to match the slider
        // value then we want to change the color of the view
        changeBackgroundColorForView(red_value:RedTextField.text,
                                     green_value:GreenTextField.text,
                                     blue_value:BlueTextField.text)
        
    } //@IBAction func RedSliderValueChanged
    
    // -----------------------------------------------------------------
    @IBAction func GreenSliderValueChanged(_ sender: Any)
    {
        GreenTextField.text = String(Int(GreenColorSlider.value))
        // after adjusting text field to match the slider
        // value then we want to change the color of the view
        changeBackgroundColorForView(red_value:RedTextField.text,
                                     green_value:GreenTextField.text,
                                     blue_value:BlueTextField.text)
    } // @IBAction func GreenSliderValueChanged
    
    // -----------------------------------------------------------------
    @IBAction func BlueSliderValueChanged(_ sender: Any)
    {
        BlueTextField.text = String(Int(BlueColorSlider.value))
        // after adjusting text field to match the slider
        // value then we want to change the color of the view
        changeBackgroundColorForView(red_value:RedTextField.text,
                                     green_value:GreenTextField.text,
                                     blue_value:BlueTextField.text)
    } // @IBAction func BlueSliderValueChanged
    
    // -----------------------------------------------------------------
    @IBAction func ChangeColor(_ sender: Any)
    {
        // action for when user
        // clicks the 'Change Color' button on the screen
        changeBackgroundColorForView(red_value:RedTextField.text,
                                     green_value:GreenTextField.text,
                                     blue_value:BlueTextField.text)
        
        self.view.endEditing(true) // hide keyboard
        
    } // @IBAction func ChangeColor
    
    // -----------------------------------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true) // hide keyboard
    }

    // -----------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // keep loaded app as black background
        // and values of 0 for all fields
        RedTextField.text   = "0"
        GreenTextField.text = "0"
        BlueTextField.text  = "0"
        
        let userDefaults = UserDefaults.standard
        RedTextField.text      = userDefaults.string(forKey: "RedTextField")
        GreenTextField.text    = userDefaults.string(forKey: "GreenTextField")
        BlueTextField.text     = userDefaults.string(forKey: "BlueTextField")
        RedColorSlider.value   = userDefaults.float(forKey: "RedColorSlider")
        GreenColorSlider.value = userDefaults.float(forKey: "GreenColorSlider")
        BlueColorSlider.value  = userDefaults.float(forKey: "BlueColorSlider")
        
        // Reference code modified from Dr. Whitney's lecture
        // Pages 37 & 38 of Doc 9 App Life Cycle, Saving Data 
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.applicationDidEnterBackground(_:)),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)
        
        changeBackgroundColorForView(red_value:RedTextField.text,
                                     green_value:GreenTextField.text,
                                     blue_value:BlueTextField.text)
        
    } // override func viewDidLoad
    
    
    // -----------------------------------------------------------------

    // general function to be used
    // for passing the text field values
    // as strings, so all code and conversions
    // can be done wrapped inside this call
    // and then change the view to the corresponding
    // R G B values, note alpha is default to 1.0
    func changeBackgroundColorForView(
        red_value:String?,
        green_value:String?,
        blue_value:String?)
    {
        
        let red_color_value =
            Double(red_value!)
        
        let green_color_value =
            Double(green_value!)
        
        let blue_color_value =
            Double(blue_value!)
        
        let view_color_scheme =
            UIColor(red:(CGFloat(red_color_value!/100)),
                    green: (CGFloat(green_color_value!/100)),
                    blue: (CGFloat(blue_color_value!/100)),
                    alpha:1.0)
        
        ColorView.backgroundColor = view_color_scheme
    } // changeBackgroundColorForView
    
    
    // Reference code modified from Dr. Whitney's lecture
    // Pages 37 & 38 of Doc 9 App Life Cycle, Saving Data
    @objc func applicationDidEnterBackground(_ notification: NSNotification)
    {
        let userDefaults = UserDefaults.standard
        if RedTextField.text != nil
        {
            userDefaults.set(RedTextField.text!, forKey: "RedTextField")
        }
        if GreenTextField.text != nil
        {
            userDefaults.set(GreenTextField.text!, forKey: "GreenTextField")
        }
        if BlueTextField.text != nil
        {
            userDefaults.set(BlueTextField.text!, forKey: "BlueTextField")
        }
        userDefaults.set(RedColorSlider.value,   forKey:"RedColorSlider")
        userDefaults.set(GreenColorSlider.value, forKey:"GreenColorSlider")
        userDefaults.set(BlueColorSlider.value,  forKey:"BlueColorSlider")
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
}//class ViewController: UIViewController

