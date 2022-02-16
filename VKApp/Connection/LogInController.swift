//
//  LogInController.swift
//  VKApp
//
//  Created by hayk on 18/05/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

public let themeColor = UIColor(red: 0.25, green: 0.43, blue: 0.65, alpha: 1.0)
public let tabbarSegueIdentifier = "presentTabbarSegue"

class LogInController: UIViewController, UITextFieldDelegate {

    //MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Actions
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        tryLogIn()
    }
    
    func tryLogIn() {
        
        hideKeyboard()
        
        if loginTextField.text == "",
            passwordTextField.text == "" {
            performSegue(withIdentifier: tabbarSegueIdentifier, sender: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .default) { _ in
                self.passwordTextField.text = ""
            }
            
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = themeColor
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Keyboard
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey:
            UIResponder.keyboardFrameEndUserInfoKey)
            as! NSValue).cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
    }
    
    //MARK: - TextFields
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 0:
            passwordTextField.becomeFirstResponder()
        case 1:
            tryLogIn()
        default:
            break
        }
        
        return true
    }
    
    //MARK: - Style
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
