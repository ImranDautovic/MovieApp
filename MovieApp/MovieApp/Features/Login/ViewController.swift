//
//  ViewController.swift
//  MovieApp
//
//  Created by Pick Jobs on 7/19/20.
//  Copyright © 2020 Pick Jobs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlet Connections -
    
    @IBOutlet var UsernameTextField: UITextField!
    @IBOutlet var PassswordTextField: UITextField!
    @IBOutlet var SignIn: UIButton!
    @IBOutlet var GoogleButton: UIButton!
    @IBOutlet var FacebookButton: UIButton!
    
    //MARK: - ViewController Life Cycle Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Button Actions -
    
    @IBAction func GoogleButton(_ sender: Any) {
        //Clicking on a google icon it redirects on a facebook site
        if let link = URL(string: "https://google.com") {
            UIApplication.shared.open(link)
        }
    }
    
    @IBAction func FacebookButton(_
        sender: Any) {
        //Clicking on a facebook icon it redirects on a facebook site
        if let link = URL(string: "https://facebook.com") {
            UIApplication.shared.open(link)
        }
    }
    
    @IBAction func SignInAction(_ sender: Any) {
        //Setting so that username and password works just for "admin" entering
        //Validation checking of username and password
        //Implementation of alertController so that we get Alert if username and password are not correct
        if UsernameTextField.text == "admin" && PassswordTextField.text == "admin" {
            print("sucessful")
        } else {
            let alertController = UIAlertController(title: "Alert", message: "Wrong username or password.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
                print("Wrong username or password");
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            print("wrong")
        }
        
        //Implementation of Navigation Controller for switching from one to another screen with a present method
        //Making Storyboard and View Controller
        //Calling Present method
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let  viewController: TableViewController = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    //Function for setting UI for SignIn Button
    fileprivate func uiSetup(){
        self.SignIn.layer.cornerRadius = 25 // Making SignIn button rounded for 25
    }
}
