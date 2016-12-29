//
//  ViewController.swift
//  VehicleMaintain
//
//  Created by Shridhar on 12/29/16.
//  Copyright © 2016 Shridhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    var googleIdToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // The sign-in flow has finished and was successful if |error| is |nil|.
        if (error == nil) {
            // Perform any operations on signed in user here.
            googleIdToken = user.authentication.idToken // Safe to send to the server
            //signInToCognito(user: user)
                        googleIdToken = user.userID                  // For client-side use only!
                        let fullName = user.profile.name
                        let givenName = user.profile.givenName
                        let familyName = user.profile.familyName
                        let email = user.profile.email
                        print(googleIdToken, fullName, email)
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
//    @IBAction func didTapSignOut(sender: AnyObject) {
//        GIDSignIn.sharedInstance().signOut()
//    }
    
    

}

