//
//  mainMenuVC.swift
//  Inventory
//
//  Created by Michael King on 4/15/16.
//  Copyright © 2016 Michael King. All rights reserved.
//


import UIKit
import Firebase
import ExpandingMenu

class MainMenuVC: UITableViewController {

    
    
    @IBOutlet weak var boxesBtn: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureExpandingMenuButton()
       
        DataService.ds.REF_CATEGORY.observeEventType(.Value, withBlock: { snapshot in
            
            if snapshot.value is NSNull {
                print("There are no categories yet")
                
   
            }
            
        })
        
        
    }//end ViewDidLoad
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureExpandingMenuButton() {
        let menuButtonSize: CGSize = CGSize(width: 64.0, height: 64.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPointZero, size: menuButtonSize), centerImage: UIImage(named: "chooser-button-tab")!, centerHighlightedImage: UIImage(named: "chooser-button-tab-highlighted")!)
        menuButton.center = CGPointMake(self.view.bounds.width - 32.0, self.view.bounds.height - 92.0)
        self.view.addSubview(menuButton)
        
        func showAlert(title: String) {
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Music", image: UIImage(named: "chooser-moment-icon-music")!, highlightedImage: UIImage(named: "chooser-moment-icon-place-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
            showAlert("Music")
        }
        
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "Place", image: UIImage(named: "chooser-moment-icon-place")!, highlightedImage: UIImage(named: "chooser-moment-icon-place-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
            showAlert("Place")
        }
        
        let item3 = ExpandingMenuItem(size: menuButtonSize, title: "Camera", image: UIImage(named: "chooser-moment-icon-camera")!, highlightedImage: UIImage(named: "chooser-moment-icon-camera-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
            showAlert("Camera")
        }
        
        let item4 = ExpandingMenuItem(size: menuButtonSize, title: "Thought", image: UIImage(named: "chooser-moment-icon-thought")!, highlightedImage: UIImage(named: "chooser-moment-icon-thought-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
            showAlert("Thought")
        }
        
        let item5 = ExpandingMenuItem(size: menuButtonSize, title: "Sleep", image: UIImage(named: "chooser-moment-icon-sleep")!, highlightedImage: UIImage(named: "chooser-moment-icon-sleep-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
            showAlert("Sleep")
        }
        
        menuButton.addMenuItems([item1, item2, item3, item4, item5])
        
        menuButton.willPresentMenuItems = { (menu) -> Void in
            print("MenuItems will present.")
        }
        
        menuButton.didDismissMenuItems = { (menu) -> Void in
            print("MenuItems dismissed.")
        }
    }
}


