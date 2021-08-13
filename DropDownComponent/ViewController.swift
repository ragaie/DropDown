//
//  ViewController.swift
//  DropDownComponent
//
//  Created by Ragaie Alfy on 8/13/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var genderDropDown: DropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        genderDropDown.delegate = self
        genderDropDown.dataSourceItems = ["Male","Female"]
    }


}

extension ViewController: DropDownDelegate{
    func dropDown(_ dropDown: DropDown, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
}
