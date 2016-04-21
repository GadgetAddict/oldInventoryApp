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
import ActionSheetPicker_3_0

class NewItemVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    
    func nameSwitchAction(nameSwitch: UISwitch) {
        if nameSwitch.on {
            customName = false
            //print("Name will be Category")
            if categoryLbl.text == "Category" {
                nameField.placeholder = "Set Category"
            } else {
                nameField.text = "\(categoryLbl.text!) \(subCategoryLbl.text!)"

            }
            
        } else {
            customName = true
             //print("Must enter item name")
            nameField.text = ""
            nameField.placeholder = "Enter Item Name"
            
        }
    }
    
    
    
    
    
    @IBAction func addToBoxBtn(sender: AnyObject) {
    //make sure form is complete and saved.

        
        
    } // end Send To Box
 
    
    @IBOutlet weak var categoryLbl: UILabel!
    
    @IBOutlet weak var subCategoryLbl: UILabel!
    
    @IBOutlet weak var colorLbl: UILabel!
  
    @IBOutlet weak var chooseColorBtn: UIButton!
    
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
    
    @IBOutlet weak var nameSwitch: UISwitch!
    @IBOutlet weak var fragilePicker: UISwitch!
    @IBOutlet weak var qtyField: styledTextField!
    
   var customName : Bool = true
    var fragileStatus : String! = "no"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorLbl.hidden = true
        subCategoryLbl.hidden = true
        chooseColorBtn.hidden = true
        
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        fragilePicker.addTarget(self, action: #selector(NewItemVC.itemIsFragile(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        nameSwitch.addTarget(self, action: #selector(NewItemVC.nameSwitchAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
 
    
    // BEGIN  Cancel and Save Buttons
    @IBAction func cancelItem(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        // which to use ? navigationController?.popViewControllerAnimated(true)

    }

   
    @IBAction func SaveNewItem(sender: AnyObject) {
        //Begin Process to Convert Data for Saving as long as Name field is not empty
    if let txt = nameField.text where txt != "" , let desc = descriptionField.text where desc != "" {
    
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
        
          self.showErrorAlert("Item Not Saved", msg: "Item name and description are required")
    self.itemToFirebase(nil)
        
    }
        self.dismissViewControllerAnimated(true, completion: nil)
print("user clicked save")
}
    
    func itemIsFragile(fragilePicker: UISwitch) {
        if fragilePicker.on {
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
        "itemQty" : qtyField.text!,
        "itemColor" : colorLbl.text!

    ]
    
 
    
    if imgUrl != nil {
        item["itemImgUrl"] = imgUrl!
    }
    
    let firebaseItem = DataService.ds.REF_ITEMS.childByAutoId()
    
    firebaseItem.setValue(item)
    //get the auto-generated key and save it
     let newItemID = firebaseItem.key
    
    //clean up
    imageSelected = false
       print("reset ImageSelected to False")
  
    //add Details to addToBox Class for when its time to relate the new item to a box
 
    
    
    
    }//end SaveItemToFireBase
 
    // Mark: Unwind Segues
    @IBAction func cancelToNewItemViewController(segue:UIStoryboardSegue) {
      self.dismissViewControllerAnimated(true, completion: nil)
    }
 
  
 
    @IBAction func saveCategoryDetail(segue:UIStoryboardSegue) {
            if let SubcategoryView = segue.sourceViewController as? SubcategoryVC {
                
                subCategoryLbl.hidden = false
         
                
                if let cats = SubcategoryView.category {
                    subCategoryLbl.text = cats.subcategoryName
                    categoryLbl.text = cats.categoryName
                    
                    if cats.categoryName == "Light" {
                        colorLbl.hidden = false
                        chooseColorBtn.hidden = false
                        nameField.text = "\(cats.subcategoryName!) \(cats.categoryName!)"
                    }
                }
        } //end if let subcateg
    }//end saveCategoryDetail
    
 
    
    //Unwind segue
    @IBAction func unwindWithSelectedColor(segue:UIStoryboardSegue) {
        if let lightColorPicker = segue.sourceViewController as? colorsVC,
            selectedColor = lightColorPicker.selectedColor {
            let color = selectedColor
            colorLbl.text = color
        }
    }
    
    

    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
  
    
    
    
}//NewItemVC
