//
//  FirstViewController.swift
//  registerandlogin
//
//  Created by Muhammed Esad Kaya on 02/09/2017.
//  Copyright © 2017 Muhammed Esad Kaya. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButton(_ sender: Any)
    {
        loginUser(urlString: "http://localhost:8888/login.php")
    }
    
    func loginUser(urlString:String)
    {
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        
        request.httpMethod = "POST"
        
        let email = emailField.text
        let pass1 = passwordField.text
        
        let paratemers = "email="+email!+"&password="+pass1!
        
        request.httpBody = paratemers.data(using: String.Encoding.utf8)
        
        
        
        if((email?.isEmpty)! || (pass1?.isEmpty)!)
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
                                
                                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomePage") as! HomeViewController
                                
                                self.present(homeVC, animated: true, completion: nil)
                                
                                
                                self.emailField.text = ""
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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

