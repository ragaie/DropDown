//
//  DropDownCell.swift
//  PranksRequest
//
//  Created by Ragaie Alfy on 7/29/21.
//

import UIKit

class DropDownCell: UITableViewCell {
    @IBOutlet weak var labeltitles: UILabel!
    
    var cellClicked:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(removeNumberTypeView))
         addGestureRecognizer(tap)
         
       
      // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

@objc func removeNumberTypeView() {
    cellClicked?()
    
}
    
}
