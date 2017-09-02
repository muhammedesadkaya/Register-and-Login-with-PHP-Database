//
//  SecondViewController.swift
//  registerandlogin
//
//  Created by Muhammed Esad Kaya on 02/09/2017.
//  Copyright © 2017 Muhammed Esad Kaya. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmField: UITextField!
    
    @IBAction func registerButton(_ sender: Any)
    {
        registerUser(urlString: "http://localhost:8888/register.php")
    }
    
    func registerUser(urlString:String)
    {
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        
        request.httpMethod = "POST"
        
        
        let name = nameField.text
        let lastName = lastNameField.text
        let email = emailField.text
        let pass1 = passwordField.text
        let pass2 = passwordConfirmField.text
        
        let paratemers = "name="+name!+"&lastName="+lastName!+"&email="+email!+"&password="+pass1!
        
        request.httpBody = paratemers.data(using: String.Encoding.utf8)
        
        
        if (pass1 != pass2)
        {
            print("password is incorrect")
        }
        if((name?.isEmpty)! || (lastName?.isEmpty)! || (email?.isEmpty)! || (pass1?.isEmpty)! || (pass2?.isEmpty)!)
        {
            print("enter all textboxes")
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil
            {
                print(error!)
            }
            else
            {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if let JsonParse = json
                    {
                        var message:String!
                        var status:String!
                        
                        message = JsonParse["mesaj"] as! String?
                        status = JsonParse["durum"] as! String?
                        
                        if(status == "basarili")
                        {
                            print(message)
                            
                            DispatchQueue.main.sync {
                                self.nameField.text = ""
                                self.lastNameField.text = ""
                                self.emailField.text = ""
                                self.passwordConfirmField.text = ""
                                self.passwordField.text = ""
                            }
                        }
                        else
                        {
                            print(message)
                        }
                        
                    }
                }
                catch
                {
                    print(error)
                }
                
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

