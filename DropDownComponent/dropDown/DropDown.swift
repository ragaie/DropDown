//
//  DropDown.swift
//  PranksRequest
//
//  Created by Ragaie Alfy on 7/29/21.
//

import UIKit
protocol DropDownDelegate {
    func dropDown(_ dropDown: DropDown, didSelectRowAt indexPath: IndexPath)
}
@IBDesignable class DropDown: UIView {
    @IBOutlet weak var itemsView: UIView!
    @IBOutlet weak var itemsTitle: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var errormessage: UILabel!
    var delegate : DropDownDelegate!

    var dataSourceItems = ["- select -"]
    var currentSelection :Int = 0
    var viewOfitems: UIView?
    var itemsTable : UITableView?
    
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
            
            itemsTitle.textColor = textColor
        }
    }
    @IBInspectable var Arrow: UIImage?  = UIImage.init(named: "arrow.png") {
        didSet {
            
            arrowImage.image = Arrow
        }
    }
    
    @IBInspectable var lableSize : CGFloat = 4.0 {
        didSet {
            itemsTitle.font = UIFont.systemFont(ofSize: lableSize)
        }
    }
    
    
    @IBInspectable var labelText : String = "-- select --" {
        didSet {
            
            itemsTitle.text = labelText
            
        }
    }
  
    
  
    // MARK: Intialisers
    override public init(frame : CGRect) {
        super.init(frame : frame)
        initSubviews()
        initActionAndDelegete()
    }
   
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        initActionAndDelegete()
    }
    func initSubviews() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DropDown", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        // to make view fit view in design you welcome.
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
       // numberType?.isHidden = true
        itemsTitle.text = dataSourceItems[0]
    }
    func initActionAndDelegete() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(showSelectionItems))
        itemsView.addGestureRecognizer(tap)
    }

      @objc func showSelectionItems() {
            let tableFrame = CGRect.init(x: itemsView.globalFrame?.minX ?? 0, y: itemsView.globalFrame?.minY ?? 0, width: itemsView.globalFrame?.width ?? 0, height: 160)
            itemsTable  = UITableView.init(frame: tableFrame, style: UITableView.Style.plain)
                        itemsTable?.register(UINib.init(nibName: "DropDownCell", bundle: nil), forCellReuseIdentifier: "DropDownCellID")
        itemsTable?.layer.cornerRadius = 7
            itemsTable?.layer.borderWidth =  1
        itemsTable?.layer.borderColor = UIColor.lightGray.cgColor
            itemsTable?.delegate = self
            itemsTable?.dataSource = self
            viewOfitems = UIView.init(frame: UIScreen.main.bounds)
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(removeItemsView))
            viewOfitems?.addGestureRecognizer(tap)
            viewOfitems?.addSubview(itemsTable ?? UITableView())
            UIApplication.shared.keyWindow?.addSubview(viewOfitems ?? UIView())
    }
    
    @objc func removeItemsView() {
        viewOfitems?.removeFromSuperview()
    }
  
}
extension DropDown : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  dataSourceItems.count
    }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCellID", for: indexPath) as? DropDownCell
            cell?.labeltitles.text = dataSourceItems[indexPath.row]
            cell?.cellClicked = {
                self.viewOfitems?.removeFromSuperview()
                self.itemsTitle.text = self.dataSourceItems[indexPath.row]
                self.currentSelection = indexPath.row
                self.itemsView.layer.borderColor = UIColor.lightGray.cgColor
                self.delegate?.dropDown(self, didSelectRowAt: indexPath)

            }
            return cell ?? DropDownCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
}
extension UIView {
    var globalFrame: CGRect? {
        let rootView = UIApplication.shared.keyWindow?.rootViewController?.view
        return self.superview?.convert(self.frame, to: rootView)
    }
}
