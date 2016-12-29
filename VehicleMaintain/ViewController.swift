//
//  ViewController.swift
//  VehicleMaintain
//
//  Created by Shridhar on 12/29/16.
//  Copyright © 2016 Shridhar. All rights reserved.
//

import UIKit
import AWSCognito

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, AWSIdentityProviderManager {
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

    func signInToCognito(user: GIDGoogleUser!) {
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.usEast1,
                                                                identityPoolId:"us-east-1:293b514e-dd0a-4fec-839b-0f368267fb6a", identityProviderManager: self)
        
        let configuration = AWSServiceConfiguration(region:.usEast1, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        credentialsProvider.getIdentityId().continue({ (task:AWSTask) -> AnyObject? in
            if (task.error != nil) {
                print(task.error!)
                return nil
            }
            
            let syncClient = AWSCognito.default()
            let dataset = syncClient?.openOrCreateDataset("VehicleMaintainDataSet")
            
            dataset?.setString(user.profile.email, forKey: "email")
            dataset?.setString(user.profile.name, forKey: "name")
            
            let result = dataset?.synchronize()
            
            result?.continue({ (task:AWSTask) -> AnyObject? in
                if task.error != nil {
                    print(task.error ?? "unknown error")
                } else {
                    self.performSegue(withIdentifier: "login", sender: self)
                }
                
                return nil
            })
            
            return nil
        })
    }
    func logins() -> AWSTask<NSDictionary> {
        let result = NSDictionary(dictionary: [AWSIdentityProviderGoogle: googleIdToken])
        return AWSTask(result: result)
    }
    
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // The sign-in flow has finished and was successful if |error| is |nil|.
        if (error == nil) {
            // Perform any operations on signed in user here.
            googleIdToken = user.authentication.idToken // Safe to send to the server
            signInToCognito(user: user)
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    

    
    

}

