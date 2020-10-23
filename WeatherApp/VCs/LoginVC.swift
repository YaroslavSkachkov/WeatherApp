//
//  LoginVC.swift
//  WeatherApp
//
//  Created by Ярослав on 10/20/20.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var eMailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    let validEMail: String = "weatherApp@test.app"
    let validPswrd: String = "123456789"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        eMailTF.delegate = self
        passwordTF.delegate = self
        hideKeyboardWhenViewTapped()
    }
    
    @IBAction func loginButonTapped(_ sender: Any) {
        checkUserData(eMail: eMailTF.text, password: passwordTF.text) { isValid in
            if isValid {
                let citiesVC = self.storyboard?.instantiateViewController(withIdentifier: "CitiesVC")
                self.navigationController?.pushViewController(citiesVC!, animated: true)
            }
        }
    }
    
    private func checkUserData(eMail: String?, password: String?, completion: (Bool)->()) {
        let email = eMail ?? ""
        let pswrd = password ?? ""
        
        if email.isEmpty && pswrd.isEmpty {
            completion(false)
            presentAlert(with: WAError.emptyBoth)
            return
        } else if email != validEMail {
            completion(false)
            presentAlert(with: WAError.invalidEMail)
            return
        } else if pswrd.isEmpty {
            completion(false)
            presentAlert(with: WAError.emptyPswrd)
            return
        } else if pswrd != validPswrd  {
            completion(false)
            presentAlert(with: WAError.invalidPswrd)
            return
        } else if email.isEmpty {
            completion(false)
            presentAlert(with: WAError.emptyEMail)
            return
        } else if email != validEMail  && pswrd != validPswrd  {
            completion(false)
            presentAlert(with: WAError.invalidBoth)
            return
        }
        completion(true)
    }
    
    private func presentAlert(with error: Error) {
        let alert = UIAlertController(title: "Warning", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController: UITextFieldDelegate {
    func hideKeyboardWhenViewTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

extension UIViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

