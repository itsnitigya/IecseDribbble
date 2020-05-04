//
//  SampleScreen.swift
//  Users
//
//  Created by Nitigya Kapoor on 03/04/20.
//

import UIKit

protocol PassingUser{
    func passUser(user:User)
}

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

class SampleScreen: UIViewController {
    
    var delegate: PassingUser?
    
    var titleLabel:UILabel = {
        let titles = UILabel()
        titles.text = "What's on your mind?"
        titles.translatesAutoresizingMaskIntoConstraints = false
        titles.font = UIFont(name: "Helvetica-Bold", size: 30)
        return titles
    }()
    var idTF: UITextField = {
        let textField=UITextField()
        setUpTextField(textField, placeHolder: "Title")
        return textField
    }()
    var nameTextField:UITextField = {
         let textField = UITextField()
         setUpTextField(textField,placeHolder: "Body")
         return textField
    }()
    var usernameTF: UITextField = {
        let textField=UITextField()
        setUpTextField(textField, placeHolder: "Username")
        return textField
    }()
    var adrTF: UITextField = {
        let textField=UITextField()
        setUpTextField(textField, placeHolder: "Address")
        return textField
    }()
    var websiteTF: UITextField = {
        let textField=UITextField()
        setUpTextField(textField, placeHolder: "Website")
        return textField
    }()
    var companyTF: UITextField = {
        let textField=UITextField()
        setUpTextField(textField, placeHolder: "Company")
        return textField
    }()
    var submit: UIButton = {
           let button=UIButton(type: .system)
           button.setTitle("Post", for: .normal)
           button.tintColor = .white
           button.backgroundColor = .systemBlue
           button.layer.cornerRadius = 5
           button.addTarget(self, action: #selector(addUser), for: .touchUpInside)
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
    func isStringContainsOnlyNumbers(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    enum SubmitError:Error{
        case fieldsCannotBeNull
    }
    @objc fileprivate func addUser()
    {
        do{
            guard let name = nameTextField.text,
            let username = usernameTF.text,
            let city = adrTF.text,
            let company = companyTF.text,
            let website = websiteTF.text,
            let id = Int(idTF.text ?? "")
            else {
                throw SubmitError.fieldsCannotBeNull
            }

            let address=Address(city:city)
            let companys=Company(name: company)
            let user=User(id: id, name: name, username: username, website: website, address: address, company: companys)
            print(user)
            delegate?.passUser(user: user)
            dismiss(animated: true, completion: nil)
            nameTextField.text=""
            adrTF.text=""
            companyTF.text=""
            websiteTF.text=""
            usernameTF.text=""
            idTF.text=""
            }
        catch {
            let alertController=UIAlertController(title: "Form not correctly filled", message: "Please fill all the details correctly", preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler:nil))
            alertController.addAction(UIAlertAction(title:"Cancel",style: .cancel,handler:nil))
            self.present(alertController, animated: true)
        }
        
    }
    fileprivate func setUpTF(_ tf:UITextField)
    {
        tf.heightAnchor.constraint(equalToConstant: 45).isActive = true
        tf.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    fileprivate func setUpView()
    {
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        idTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        setUpTF(idTF)
        
        nameTextField.topAnchor.constraint(equalTo: idTF.bottomAnchor, constant: 20).isActive = true
        setUpTF(nameTextField)
        submit.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30).isActive = true
        submit.heightAnchor.constraint(equalToConstant: 45).isActive = true
        submit.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        submit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        view.addSubview(nameTextField)
         view.addSubview(idTF)
        view.addSubview(titleLabel)
        view.addSubview(submit)
        setUpView()
    }
}



