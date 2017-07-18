//
//  DropDown.swift
//  SomeWorkTest
//
//  Created by Ragaie alfy on 7/9/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit


protocol DropDownDelegate {
    
  
    func dropDown(_ dropDown: DropDown, didSelectRowAt indexPath: IndexPath)

    
}


//extension UIResponder {
//    func owningViewController() -> UIViewController? {
//        var nextResponser = self
//        while let next = nextResponser.next {
//            nextResponser = next
//            if let vc = nextResponser as? UIViewController {
//                return vc
//            }
//        }
//        return nil
//    }
//}

@IBDesignable class DropDown: UIView ,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var actionOfDrop: UIButton!
    
    public var ID : String! = "DropDown"
    private  var tableData : UITableView!
    private  var showDrop : Bool! = false
    
    
    
    
    var dataSourceItem : [Any]! = []/// ["ghjghjghjhj","etertret","fsfsfs"]
    var delegate : DropDownDelegate!
    
  
    
    
    @IBInspectable var cornerRadius: CGFloat = 0.1 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
            
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.blue {
        didSet {
            
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var textColor: UIColor = UIColor.blue {
        didSet {
            
            itemLabel.textColor = textColor
        }
    }
    
    @IBInspectable var Arrow: UIImage?  = UIImage.init(named: "arrow.png") {
        didSet {
            
            arrowImage.image = Arrow
        }
    }
    
    @IBInspectable var lableSize : CGFloat = 4.0 {
        didSet {
            
            itemLabel.font = UIFont.systemFont(ofSize: lableSize)

            
        }
    }
    
    
    @IBInspectable var labelText : String = "select Item .." {
        didSet {
            
            itemLabel.text = labelText
            
        }
    }
  
    @IBInspectable var RestorationId : String!{
        didSet {
            
            ID = RestorationId
            
        }
    }
    //MARK: Initializers
    override init(frame : CGRect) {
        super.init(frame : frame)
        initSubviews()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        initActionAndDelegete()

    }
//////
    
    var title: String? {
        get { return itemLabel?.text }
        set { itemLabel.text = newValue }
    }
  
    var image: UIImage? {
        get { return arrowImage.image }
        set { arrowImage.image = newValue }
    }

    
    
func initSubviews() {

    let bundle = Bundle(for: type(of: self))
    
    
    let nib = UINib(nibName: "DropDown", bundle: bundle)
    
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    // to make view fit view in design you welcome.
    view.frame = self.bounds
    // Make the view stretch with containing view
    // to fit like you want in storyboard
    view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
   // nib.contentView.frame = bounds
    addSubview(view)
        
        // custom initialization logic
   
}

   
    
    
    // add action of dropDown
    func initActionAndDelegete()  {
    
        
        actionOfDrop.addTarget(self, action: "showSelection:", for: .touchUpInside)
    }

    
    
    
    
    func showSelection(_ sender : UIButton)  {
        
        if showDrop == true {
            
            tableData.removeFromSuperview()
            showDrop = false
        }
        else{
            if tableData == nil {
        
                tableData  = UITableView.init(frame: CGRect.init(x: frame.minX + 5 , y: frame.minY + frame.height, width: frame.width - 10, height:  CGFloat(30 * dataSourceItem.count)))
                tableData.dataSource = self
                tableData.delegate = self
        
                tableData.layer.borderWidth = self.borderWidth
                tableData.layer.borderColor = self.borderColor.cgColor
        
            }
          // get owner that containe this view
            
            self.owningViewController()?.view.addSubview(tableData)
            
            showDrop = true
        }
        //self.addSubview(tableData)
    
       // print("welcome to selction")
    }
    
  
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemLabel.text = "\(dataSourceItem[indexPath.row])"
        
        if delegate != nil {
            self.delegate.dropDown(self, didSelectRowAt: indexPath)
        }
        tableData.removeFromSuperview()
        showDrop = false

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSourceItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var cell : UITableViewCell! = UITableViewCell.init(frame: CGRect.init(x: frame.minX + 5 , y: frame.minY + frame.height, width: frame.width - 10, height: CGFloat(20 * dataSourceItem.count)))
        
//        CGRect.init(x: frame.minX + 10   , y: frame.minY + frame.height, width: frame.width - 20, height: CGFloat(20 * dataSourceItem.count)
//        
//        CGRect.init(x: frame.minX + intentSpace  , y: frame.minY + frame.height, width: frame.width - (intentSpace * 2 ), height: 100)
//        
        cell.textLabel?.text = "\(dataSourceItem[indexPath.row])"
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
}



// viewcontroller that contain this view
extension UIResponder {
    func owningViewController() -> UIViewController? {
        var nextResponser = self
        while let next = nextResponser.next {
            nextResponser = next
            if let vc = nextResponser as? UIViewController {
                return vc
            }
        }
        return nil
    }
}









