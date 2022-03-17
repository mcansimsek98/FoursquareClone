//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Mehmet Can Şimşek on 17.03.2022.
//

import UIKit
import Parse

class SingUpVC: UIViewController {
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
      
        
    }

    @IBAction func singinClicked(_ sender: Any) {
        //GİRİŞ İŞLEMLERİ
        if usernameText.text != "" && passwordText.text != ""{
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription  ?? "Error")
                }else {
                    //segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                }
            }
        }else {
            makeAlert(titleInput: "Error", messageInput: "Username / Passwords ??")
        }
    }
    
    @IBAction func singupClicked(_ sender: Any) {
        //KULLANICI OLUŞTURMA
        if usernameText.text != "" && passwordText.text != ""{
            let user = PFUser()
            user.username = usernameText.text!
            user.password = passwordText.text!
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    // Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(titleInput:"Error" , messageInput:"Username / Password ??")

        }
    }
    
    //ALERT-UYARI FONKSİYONU
    func makeAlert(titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

