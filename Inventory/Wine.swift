//
//  Wine.swift
//  Inventory
//
//  Created by Michael King on 4/1/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import Foundation
import Firebase

class Wine  {
    private var _wineKey: String!
    private var _wineRef: Firebase!
    private var _wineImgUrl: String?
    private var _wineQr: String?
    private var _wineName: String!
    private var _wineType: String!
    private var _wineDescript: String?
    private var _wineVintage: String?
    private var _wineVintner: String!
    private var _wineRating: Double?
    private var _wineDrinkBy: String?
    private var _wineLibrary: Bool!
    private var _wineShelf: String?
    private var _wineBin: String?
    
    var wineKey: String {
        return _wineKey
    }

    var wineImgUrl: String? {
        return _wineImgUrl
    }
    var wineQr: String? {
        return _wineQr
    }

    var wineName: String {
        return _wineName
    }
    
    var wineType: String {
        return _wineType
    }
    
    var wineDescript: String? {
        return _wineDescript
    }
    
    var wineVintage: String? {
        return _wineVintage
    }

    var wineVintner: String {
        return _wineVintner
    }

    var wineRating: Double? {
        return _wineRating
    }

    var wineDrinkBy: String? {
        return _wineDrinkBy
    }

    var wineLibrary: Bool {
        return _wineLibrary
    }
    
    var wineShelf: String? {
        return _wineShelf
    }
    
    var wineBin: String? {
        return _wineBin
    }

    init(name: String, type: String, imageUrl: String?,  maker: String, vintage: String, description: String) {
        self._wineName = wineName
        self._wineDescript = description
        self._wineImgUrl = imageUrl
    }
    
    
    init (wineKey: String, dictionary: Dictionary <String, AnyObject> ) {
        self._wineKey = wineKey
        
        if let wineName = dictionary["name"] as? String {
            self._wineName = wineName
    }
        
        if let wineImgUrl = dictionary["imageUrl"] as? String {
            self._wineImgUrl = wineImgUrl
    }

        if let wineType = dictionary["type"] as? String {
            self._wineType = wineType
    }
     
        if let qr = dictionary["qr"] as? String {
           self._wineQr = qr
    }
    
        if let desc = dictionary["description"] as? String {
           self._wineDescript = desc
    }

        if let vintage = dictionary["vintage"] as? String {
            self._wineVintage = vintage
    }

    if let vintner = dictionary["vintner" ] as? String {
            self._wineVintner = vintner
    }

    if let rating = dictionary["rating"]  as? Double {
            self._wineRating = rating
    }

    if let drinkBy = dictionary["drinkBy"]  as? String {
            self._wineDrinkBy =  drinkBy
    }

    if let library = dictionary["library"] as? Bool {
            self._wineLibrary = library
    }
        
    if let shelf = dictionary["shelf"] as? String {
        self._wineShelf = shelf
    }
        
    if let bin = dictionary["bin"] as? String {
        self._wineBin = bin
    }
        
        self._wineRef = DataService.ds.REF_CELLAR.childByAppendingPath(self._wineKey)
    } // init



} // class



