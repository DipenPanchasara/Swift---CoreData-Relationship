//
//  Constants.swift
//  CoreDataSample
//
//  Created by Dipen Panchasara on 03/06/16.
//  Copyright © 2016 CoreData Sample. All rights reserved.
//

import Foundation
import UIKit

let kUserAddress     = "address"

let appDel = UIApplication.sharedApplication().delegate as! AppDelegate

struct Constants
{
    static let kFirstName   = "firstName"
    static let kLastName    = "lastName"
    static let kEmail       = "email"
    
    static let kStreet      = "street"
    static let kLocality    = "locality"
    static let kCity        = "city"
    static let kState       = "state"
    static let kCountry     = "country"
    
    static let kAddress     = "address"
    
}

struct CoreData
{
    static let UserEntity       = "User"
    static let AddressEntity    = "Address"
}