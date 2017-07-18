//
//  ViewController.swift
//  DropDown-Chtar
//
//  Created by Ragaie alfy on 7/18/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,DropDownDelegate{

    
    
    @IBOutlet weak var firstDropDown: DropDown!
    
    
    @IBOutlet weak var secandDropDown: DropDown!
    
    var items1 = ["item1","item2","item3"]
    
    
    var items2 = ["item21","item22","item23"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        firstDropDown.dataSourceItem = items1
        secandDropDown.dataSourceItem = items2
        firstDropDown.delegate = self
        secandDropDown.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func dropDown(_ dropDown: DropDown, didSelectRowAt indexPath: IndexPath) {
        
        ///sdf
        
        if dropDown.ID == "1"{
        
            print(items1[indexPath.row])
        }
        else
        
        {
        
        print(items2[indexPath.row])
        }
        
    }

}

