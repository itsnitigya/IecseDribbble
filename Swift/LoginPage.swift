//
//  LoginPage.swift
//  Users
//
//  Created by Nitigya Kapoor on 04/05/20.
//

import Foundation
import Alamofire
import UIKit

fileprivate func setUpTextField(_ textField: UITextField,placeHolder: String) {
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = placeHolder
    textField.keyboardType = UIKeyboardType.default
    textField.returnKeyType = UIReturnKeyType.done
    textField.autocorrectionType = UITextAutocorrectionType.no
    textField.font = UIFont.systemFont(ofSize: 20)
    textField.textColor = UIColor.label
    textField.tintColor = UIColor.secondaryLabel
    textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel])
    textField.borderStyle = UITextField.BorderStyle.roundedRect
    textField.layer.borderColor = UIColor.secondaryLabel.cgColor
    textField.layer.borderWidth = 0.5
    textField.layer.cornerRadius = 5
    textField.clearButtonMode = UITextField.ViewMode.whileEditing
    textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
}



class LoginScreen : UIViewController  , UITextFieldDelegate{
    
    var iecseLogo : UIImageView = {
        var img = UIImageView()
        img.image = UIImage(named: "iecse_white")!
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    var user : UIButton = {
        let follow = UIButton()
        follow.setImage(UIImage(systemName: "person.fill"), for: .normal)
        follow.translatesAutoresizingMaskIntoConstraints = false;
        return follow
    }()
    
    var pass : UIButton = {
        let mention = UIButton()
        mention.setImage(UIImage(systemName: "lock.fill"), for: .normal)
        mention.translatesAutoresizingMaskIntoConstraints = false;
        return mention
    }()
    
    var aether : UILabel = {
        var text = UILabel()
        text.text = "DRIBBBLE"
        text.textColor = .systemPink
        text.font = .boldSystemFont(ofSize: 50)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var forgot : UIButton = {
        var button = UIButton()
        button.setTitle("Forgot Password ?", for: .normal)
        //button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var username : UITextField = {
         let textField = UITextField()
         setUpTextField(textField,placeHolder: "")
         return textField
    }()
    
    var password : UITextField = {
        let textField=UITextField()
        setUpTextField(textField, placeHolder: "")
        return textField
    }()
    
    var loginButton : UIButton = {
        var button = UIButton()
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
       // button.makeRounded()
        button.backgroundColor = .blue
        button.sizeToFit()
        button.frame.size = CGSize(width: 100.0, height: 100.0)
        button.makeRounded()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToSecondScreen), for: .touchUpInside)
        return button
    }()

    struct Login : Codable {
        var email : String
        var password : String
    }

    
    @objc func goToSecondScreen(){
        let data : [String : Any] = ["email":/* username.text ??*/ "kapoornitigya@gmail.com" , "password" : /* password.text ??*/ "abc"]
        
        Alamofire.request("http://ee0ad3c5.ngrok.io/login" , method: .post , parameters: data , encoding: JSONEncoding.default).responseJSON {(response) in
            if(response.result.isSuccess){
                print(response)
                let firstScreen = MasterTabBarController()
                firstScreen.modalPresentationStyle = .fullScreen
                self.present(firstScreen, animated: true, completion: nil)
            }
            else{
               let alertController=UIAlertController(title: "Wrong Password/Email", message: "Please fill all the details correctly", preferredStyle: .actionSheet)
               alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler:nil))
               alertController.addAction(UIAlertAction(title:"Cancel",style: .cancel,handler:nil))
               self.present(alertController, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .red
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        view.addSubview(iecseLogo)
        view.addSubview(aether)
        view.addSubview(loginButton)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(user)
        view.addSubview(pass)
        username.delegate = self
        password.delegate = self
        _ = textFieldShouldReturn(username)
        _ = textFieldShouldReturn(password)
        setupConstraints()
    }
    
    func setupConstraints(){
        iecseLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        iecseLogo.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 290 ).isActive = true
        iecseLogo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 85).isActive = true
        iecseLogo.widthAnchor.constraint(equalToConstant: 255).isActive = true
        
        aether.topAnchor.constraint(equalTo: iecseLogo.bottomAnchor, constant: 40).isActive = true
        aether.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        username.topAnchor.constraint(equalTo: aether.bottomAnchor, constant: 40).isActive = true
        //username.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        username.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 85).isActive = true
        username.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -85).isActive = true
        username.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 40).isActive = true
        password.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 85).isActive = true
        password.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -85).isActive = true
        password.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        user.topAnchor.constraint(equalTo: aether.bottomAnchor, constant: 40).isActive = true
        user.heightAnchor.constraint(equalToConstant: 40).isActive = true
        user.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 55).isActive = true
        
        pass.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 40).isActive = true
        pass.heightAnchor.constraint(equalToConstant: 40).isActive = true
        pass.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 55).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 100).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: password.bottomAnchor, constant: 165).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}


extension UIButton {
    func makeRounded() {
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 65 / 2
        self.clipsToBounds = true
    }
}
