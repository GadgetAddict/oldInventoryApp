//
//  NewItemVC.swift
//  Inventory
//
//  Created by Michael King on 4/6/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import Firebase
import Alamofire


class NewItemVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate, DestinationViewDelegate {

 
    
    @IBOutlet weak var categoryLbl: UILabel!
    
    @IBOutlet weak var subCategoryLbl: UILabel!
    
    @IBOutlet weak var colorLbl: UILabel!
  
    var item = [Item]()
    
    // Set up Image
    var imageSelected = false
    
    var imagePicker: UIImagePickerController!
    
    static var imageCache = NSCache()
    
   @IBOutlet weak var imageThumbnail: UIImageView!
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageThumbnail.image = image
        imageSelected = true
    }
    
    @IBAction func selectImage(sender: UITapGestureRecognizer) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    // Set up Text Input
    @IBOutlet weak var nameField: styledTextField!
    @IBOutlet weak var descriptionField:UITextView!
    
     @IBOutlet weak var fragilePicker: UISwitch!
    @IBOutlet weak var qtyField: styledTextField!
    
  
    var fragileStatus : String! = "no"

    override func viewDidLoad() {
        super.viewDidLoad()
        colorLbl.hidden = true
        subCategoryLbl.hidden = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        fragilePicker.addTarget(self, action: #selector(NewItemVC.switchIsChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
 
    }
    
 
    
    // BEGIN  Cancel and Save Buttons
    @IBAction func cancelItem(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        // which to use ? navigationController?.popViewControllerAnimated(true)

    }

   
    @IBAction func SaveNewItem(sender: AnyObject) {
      print("user clicked save")
        
    if let txt = nameField.text where txt != "" {
    
    if let img = imageThumbnail.image where imageSelected == true {
 
    let urlStr = "https://post.imageshack.us/upload_api.php"

    let url = NSURL(string: urlStr)!
    // convert image to data and compress into jpeg - compress a LOT!
    let imgData = UIImageJPEGRepresentation(img, 0.2)!
    // using alamofire send multipart form data request
    // Convert API Key to Data
    let keyData = API.dataUsingEncoding(NSUTF8StringEncoding)!
    // Convert JSON to Data
    let keyJSON = "json".dataUsingEncoding(NSUTF8StringEncoding)!
    
    Alamofire.upload(.POST, url, multipartFormData: { multipartFormData in
    
    multipartFormData.appendBodyPart(data: imgData, name: "fileupload", fileName: "image", mimeType: "image/jpg")
    multipartFormData.appendBodyPart(data: keyData, name: "key")
    multipartFormData.appendBodyPart(data: keyJSON, name: "format")
    
        })
    { encodingResult in
    
    switch encodingResult {
    case .Success(let upload, _, _):
    upload.responseJSON(completionHandler:  {(response)in
    // Get the JSON
    if let info = response.result.value as? Dictionary<String, AnyObject> {
    if let links = info["links"] as? Dictionary<String, AnyObject> {
    if let imgLink = links["image_link"] as? String {
    print("LINK: \(imgLink)")
    self.itemToFirebase(imgLink)
        
                }
            }
        }
    })
    
    case .Failure(let error):
    print(error)
    
    } //end switch
    
    } // end encoding result in
    
            }//ifLetImage
        } else {
    self.itemToFirebase(nil)
    }
    
     navigationController?.popViewControllerAnimated(true)

}
   
    func switchIsChanged(mySwitch: UISwitch) {
        if mySwitch.on {
            fragileStatus = "yes"
        } else {
            fragileStatus = "no"
        }
    }
    
func itemToFirebase(imgUrl: String?) {
   
    var item: Dictionary<String, AnyObject> = [
        "itemName" : nameField.text!,
        "itemDescript" : descriptionField.text!,
        "itemFragile" : fragileStatus!,
        "itemCategory" : categoryLbl.text! ,
         "itemSubcategory" :  subCategoryLbl.text! ,
        "itemQty" : qtyField.text!

    ]
    if imgUrl != nil {
        item["itemImgUrl"] = imgUrl!
    }
    
    let firebaseItem = DataService.ds.REF_ITEMS.childByAutoId()
    firebaseItem.setValue(item)
    
    } //save item ToFirebase
 
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "SavePlayerDetail" {
//            player = Player(name: nameTextField.text, game:game, rating: 1)
//        }
//            }
//    
//    //Unwind segue
//    @IBAction func unwindWithSelectedGame(segue:UIStoryboardSegue) {
//        if let NewSubcategoryVC = segue.sourceViewController as? NewSubcategoryVC,
//            passedCategory = NewSubcategoryVC.selectedCategory {
//            newcategory = selectedCategory
//        }
//            passedSubcategory = NewSubcategoryVC.selectedSubcategory {
//            newSubcategory = selectedSubcategory
//        }
//    }
//    
    
    
    // Mark Unwind Segues
    @IBAction func cancelToNewItemViewController(segue:UIStoryboardSegue) {
    }
 
  
    
    // Called from the destination controller via delegation
    func setCats(subcategory: String) {
        categoryLbl.text = "category"
        subCategoryLbl.text = subcategory
         
    }
    
    
    
}//NewItemVC
