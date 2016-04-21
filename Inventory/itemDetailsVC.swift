//
//  itemDetailsVC.swift
//  Inventory
//
//  Created by Michael King on 4/5/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import BubbleTransition
import Firebase
import Alamofire

class itemDetailsVC: UIViewController, UIViewControllerTransitioningDelegate {
    
    var request: Request?

    var passedItem = ""
    
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemDescription: UILabel!
    
    @IBOutlet weak var itemCat: UILabel!
    
    @IBOutlet weak var subcatLabel: UILabel!
    @IBOutlet weak var itemSubcat: UILabel!
    
    @IBOutlet weak var itemColor: UILabel!
    
    @IBOutlet weak var itemBox: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var qtyView: styledView!
    
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var fragileView: styledView!
    
    @IBOutlet weak var fragile: UILabel!
    
    
    @IBAction func doneButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        
           // print(passedItem)
   
            //hide items
        self.fragile.hidden = true
        self.fragileView.hidden = true
        
              let ref = Firebase(url: "\(URL_BASE)/Items/\(passedItem)")
               ref.observeEventType(.Value, withBlock: { snapshot in
                  //print(snapshot.value)
                
                self.itemName.text = snapshot.value["itemName"] as? String
               
                if let fragile = snapshot.value["itemFragile"] as? String {
                    if fragile == "yes" {
                        self.fragile.hidden = false
                        self.fragileView.hidden = false
                        self.fragile.text = "Fragile"
                    
                } else {
                        self.fragile.hidden = true
                        self.fragileView.hidden = true
                    }
                    
                }
                
                self.quantity.text = snapshot.value["itemQty"] as? String

                self.itemDescription.text = snapshot.value["itemDescript"] as? String

                self.itemCat.text = snapshot.value["itemCategory"] as? String

                self.itemSubcat.text = snapshot.value["itemSubcategory"] as? String

                self.itemColor.text = snapshot.value["itemColor"] as? String

                self.itemBox.text = snapshot.value["itemInBox"] as? String

                
                if let img = snapshot.value["itemImgUrl"] as? String {
                    self.request = Alamofire.request(.GET, img).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
                            
                            if err == nil {
                                let img = UIImage(data: data!)!  // Convert to image
                                self.image1.image = img
                                 }
                        })
                        
                    } else {
                    self.image1.hidden = true
                }
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
          }

    let transition = BubbleTransition()

 

    @IBOutlet weak var boxMeLbl: UIButton!
    
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
    }
 
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = boxMeLbl.center
        transition.bubbleColor = boxMeLbl.backgroundColor!
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = boxMeLbl.center
        transition.bubbleColor = boxMeLbl.backgroundColor!
        return transition
}
    
    
}//endClass
