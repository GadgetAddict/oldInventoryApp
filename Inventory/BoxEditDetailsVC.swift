//
//  BoxDetailsVC.swift
//  Inventory
//
//  Created by Michael King on 4/15/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit

class BoxEditDetailsVC: UIViewController {
    var passedQR : String!
   
    @IBAction func saveBoxDetailsBtn(sender: UIBarButtonItem) {
    }
    
    @IBAction func cancelBtn(sender: UIBarButtonItem) {
    }
    
    @IBOutlet weak var boxNumberLbl: UILabel!
    
    @IBOutlet weak var categoryLbl: UIButton!
    
    @IBOutlet weak var statusLbl: UIButton!
    
    @IBOutlet weak var fragileImg: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
