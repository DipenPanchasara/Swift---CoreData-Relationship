//
//  UserDetailViewController.swift
//  CoreDataSample
//
//  Created by Dipen Panchasara on 03/06/16.
//  Copyright © 2016 CoreData Sample. All rights reserved.
//

import UIKit
import CoreData

class UserDetailViewController: UIViewController {

    @IBOutlet weak var lblFullName:UILabel!
    @IBOutlet weak var lblEmail:UILabel!
    @IBOutlet weak var lblAddress:UILabel!
    @IBOutlet weak var lblCity:UILabel!
    @IBOutlet weak var lblState:UILabel!
    @IBOutlet weak var lblCountry:UILabel!
    
    var objectID: NSManagedObjectID!
    
    // MARK: Private Variable
    private var objUser:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        objUser = User.getUserObjectWithObjectId(self.objectID)
        
        if objUser != nil
        {
            self.title = objUser.firstName
            
            lblFullName.text = NSString(format: "\(objUser.firstName!) \(objUser.lastName!)") as String
            lblEmail.text = objUser.email
            
            let objAddress:Address! = objUser.valueForKey(Constants.kAddress)?.allObjects[0] as! Address
            
            if objAddress != nil
            {
                lblAddress.text = NSString(format: "\(objAddress.street!), \(objAddress.locality!)") as String
                lblCity.text = objAddress.city!
                lblState.text = objAddress.state!
                lblCountry.text = objAddress.country!
            }
        }
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
