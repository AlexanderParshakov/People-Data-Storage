//
//  SignInViewController.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/18/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Cocoa

class SignInViewController: NSViewController {

    @IBOutlet weak var loginTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    @IBOutlet weak var signInButton: NSButton!
    @IBOutlet weak var failureLabel: NSTextField!
    
    
    @IBAction func onLoginAction(_ sender: Any) {
        signIn()
    }
    @IBAction func onPasswordAction(_ sender: Any) {
        signIn()
    }
    @IBAction func onSignInClicked(_ sender: Any) {
        signIn()
    }
    
    var timer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSignInButton()
        stylizeTextField(named: loginTextField)
        stylizeTextField(named: passwordTextField)
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.center()
    }
    func setupSignInButton() {
        signInButton.wantsLayer = true
        signInButton.layer?.backgroundColor = NSColor.systemGreen.cgColor
        signInButton.layer?.cornerRadius = 15
        signInButton.contentTintColor = .white
    }
    func stylizeTextField(named field: NSTextField) {
        field.wantsLayer = true
        field.layer?.borderColor = NSColor.systemGreen.cgColor
        field.layer?.borderWidth = 1
        field.layer?.cornerRadius = 7
    }
    func signIn() {
        loginTextField.isEditable = false
        passwordTextField.isEditable = false
        
        progressIndicator.startAnimation(nil)
        progressIndicator.isHidden = false
        signInButton.isEnabled = false
        failureLabel.isHidden = true
        
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
            let user = User(login: self.loginTextField.stringValue, password: self.passwordTextField.stringValue)
            
            if user.signIn() == true {
                self.performSegue(withIdentifier: "showMainMenu", sender: self)
                self.view.window?.close()
            }
            else {
                self.loginTextField.isEditable = true
                self.passwordTextField.isEditable = true
                
                self.progressIndicator.stopAnimation(nil)
                self.progressIndicator.isHidden = true
                self.signInButton.isEnabled = true
                self.failureLabel.isHidden = false
            }
        })
    }
}
