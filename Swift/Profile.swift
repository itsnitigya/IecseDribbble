//
//  profile.swift
//  Users
//
//  Created by Nitigya Kapoor on 04/05/20.
//

import UIKit

class HomeScreen : UIViewController {

    let userInfo = UIView()
    
    var name : UILabel = {
        let name = UILabel()
        name.textColor = UIColor.label
        name.font = .boldSystemFont(ofSize: 25)
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    var navigationView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.dropShadow()
        return view
    }()
    
    var iecseLogo : UIButton = {
        let iecseLogo = UIButton()
        iecseLogo.setImage(UIImage(named: "iecse"), for: .normal)
        iecseLogo.translatesAutoresizingMaskIntoConstraints = false
        iecseLogo.sizeToFit()
        return iecseLogo
    }()
    
    var profilePicture : UIImageView = {
        let profilePicture = UIImageView()
        profilePicture.image = UIImage(named : "defaultUserImage")
        //profilePicture.layer.borderWidth = 10
        profilePicture.makeRounded()
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        return profilePicture
    }()
    
    var logoutLogo : UIButton = {
        let logoutLogo = UIButton()
        logoutLogo.setImage(UIImage(named: "logout"), for: .normal)
        logoutLogo.translatesAutoresizingMaskIntoConstraints = false
        logoutLogo.addTarget(self, action: #selector(goToLoginScreen), for: .touchUpInside)
        return logoutLogo
    }()
    
    var follow : UIButton = {
        let follow = UIButton()
        follow.setImage(UIImage(systemName: "person.3.fill"), for: .normal)
        follow.translatesAutoresizingMaskIntoConstraints = false;
        return follow
    }()
    
    var mention : UIButton = {
        let mention = UIButton()
        mention.setImage(UIImage(systemName: "star.fill"), for: .normal)
        mention.translatesAutoresizingMaskIntoConstraints = false;
        return mention
    }()
    
    var followCount : UILabel = {
        let followCount  = UILabel()
        followCount .translatesAutoresizingMaskIntoConstraints = false
        followCount .font = UIFont.boldSystemFont(ofSize: 15)
        followCount.text = String(132)
        return followCount
    }()
    
    var mentionCount : UILabel = {
        let mentionCount = UILabel()
        mentionCount .translatesAutoresizingMaskIntoConstraints = false
        mentionCount.font = UIFont.boldSystemFont(ofSize: 15)
        mentionCount.text = String(37)
        return mentionCount
    }()
    
    func someHandler(alert: UIAlertAction!) {
        let loginScreen = LoginScreen()
        loginScreen.modalPresentationStyle = .fullScreen
        present(loginScreen , animated: true)
    }
    
    @objc func goToLoginScreen(){
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to logout?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: someHandler))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    var email : UILabel = {
        let email = UILabel()
        email.text = "Kapoornitigya@gmail.com"
        //email.font = .boldSystemFont(ofSize: 25)
        email.textAlignment = .center
        email.textColor = UIColor.label
        email.font = .systemFont(ofSize: 15)
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    var qrImage : UIImageView = {
        let qrImage = UIImageView()
        qrImage.image = UIImage(named: "qr")
        qrImage.translatesAutoresizingMaskIntoConstraints = false
        return qrImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setupView()
    }
    
    func setupView(){
        userInfo.backgroundColor = .white
        view.addSubview(userInfo)
        userInfo.addSubview(name)
        userInfo.addSubview(profilePicture)
        userInfo.addSubview(email)
        userInfo.addSubview(followCount)
        userInfo.addSubview(follow)
        userInfo.addSubview(mentionCount)
        userInfo.addSubview(mention)
        setUserInfoConstraints()
        //set()
    }
    
    func setUserInfoConstraints(){
        userInfo.translatesAutoresizingMaskIntoConstraints =  false
        userInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        userInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        userInfo.heightAnchor.constraint(equalToConstant: 310).isActive = true
        userInfo.centerYAnchor.constraint(equalTo : view.centerYAnchor).isActive = true
        userInfo.layer.cornerRadius = 20
        userInfo.backgroundColor = UIColor.secondarySystemBackground
        userInfo.dropShadow()
        
        profilePicture.centerXAnchor.constraint(equalTo: userInfo.centerXAnchor).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profilePicture.topAnchor.constraint(equalTo: view.topAnchor , constant: 242).isActive = true
        
        name.leadingAnchor.constraint(equalTo: userInfo.leadingAnchor, constant: 10).isActive = true
        name.trailingAnchor.constraint(equalTo: userInfo.trailingAnchor, constant: -10).isActive = true
        name.topAnchor.constraint(equalTo: userInfo.topAnchor , constant: 60).isActive = true
        
        email.leadingAnchor.constraint(equalTo: userInfo.leadingAnchor, constant: 10).isActive = true
        email.trailingAnchor.constraint(equalTo: userInfo.trailingAnchor, constant: -10).isActive = true
        email.topAnchor.constraint(equalTo: name.topAnchor , constant: 50).isActive = true
        
        follow.leadingAnchor.constraint(equalTo: userInfo.leadingAnchor, constant: 120).isActive = true
        follow.topAnchor.constraint(equalTo: email.topAnchor , constant: 40).isActive = true
        
        mention.leadingAnchor.constraint(equalTo: userInfo.leadingAnchor, constant: 125).isActive = true
        mention.topAnchor.constraint(equalTo: follow.topAnchor , constant: 30).isActive = true
        
        followCount.leadingAnchor.constraint(equalTo: follow.trailingAnchor, constant: 40).isActive = true
        followCount.topAnchor.constraint(equalTo: email.topAnchor, constant: 40).isActive = true
        
        mentionCount.leadingAnchor.constraint(equalTo: follow.trailingAnchor, constant: 40).isActive = true
        mentionCount.topAnchor.constraint(equalTo: follow.topAnchor, constant: 30).isActive = true
        
    }
    
    func set() {
        self.name.text = String("By itsnitigya")
            mentionCount.text = String(100)
            followCount.text = String(132)
            email.text = "Kapoornitigya@gmail.com"
    //        username.text = String(res.username)
    //        name.text = String(res.name)
    //        websiteImage.image = UIImage(named: "UI")
    //        website.text = String(res.website)
    //        voteCount.text = String(50)
    //        commentCount.text = String(20)
        }

}


extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        layer.shouldRasterize = true
    }
}

extension UIImageView {

    func makeRounded() {
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 100 / 2
        self.clipsToBounds = true
    }
}

