//
//  TableViewCell.swift
//  Users
//
//  Created by Nitigya Kapoor on 30/03/20.
//

import UIKit


class UserCell : UITableViewCell {
    
    var backgroundCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.layer.cornerRadius = 16
        view.backgroundColor = UIColor.secondarySystemBackground
        view.clipsToBounds = true
        return view
    }()
    
    var vote : UIButton = {
        let vote = UIButton()
        vote.setImage(UIImage(systemName: "heart"), for: .normal)
        vote.translatesAutoresizingMaskIntoConstraints = false;
        vote.addTarget(self, action: #selector(voteMe), for: .touchUpInside)
        return vote
    }()
    
    @objc func voteMe(){
        print("voted")
    }
    
    var comment : UIButton = {
        let comment = UIButton()
        comment.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        comment.translatesAutoresizingMaskIntoConstraints = false;
        return comment
    }()
    
    var share : UIButton = {
        let share = UIButton()
        share.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        share.translatesAutoresizingMaskIntoConstraints = false;
        return share
    }()
    
    var voteCount : UILabel = {
        let votecount = UILabel()
        votecount.translatesAutoresizingMaskIntoConstraints = false
        votecount.font = UIFont.boldSystemFont(ofSize: 15)
        return votecount
    }()
    
    var commentCount : UILabel = {
        let commentcount = UILabel()
        commentcount .translatesAutoresizingMaskIntoConstraints = false
        commentcount.font = UIFont.boldSystemFont(ofSize: 15)
        return commentcount
    }()

    var username: UILabel = {
       let username = UILabel()
        username.translatesAutoresizingMaskIntoConstraints = false
        username.font = UIFont.boldSystemFont(ofSize: 25)
        return username
    }()
    
    var name: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 15)
        name.textColor = UIColor.label
        return name
    }()

    var website : UILabel = {
        let website = UILabel()
        website.translatesAutoresizingMaskIntoConstraints = false
        website.font = UIFont.systemFont(ofSize: 20)
        return website
    }()
    
    var websiteImage : UIImageView = {
        let wsimg = UIImageView()
        wsimg.translatesAutoresizingMaskIntoConstraints = false
        wsimg.clipsToBounds = true
        return wsimg
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,reuseIdentifier: reuseIdentifier)
        addSubview(backgroundCard)
        addSubview(username)
        addSubview(name)
        addSubview(websiteImage)
        //addSubview(website)
        addSubview(vote)
        addSubview(comment)
        addSubview(share)
        addSubview(commentCount)
        addSubview(voteCount)
        setLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelConstraints() {
           backgroundCardConstraints()
           usernameConstraints()
           nameConstraints()
           websiteImageConstraints()
          // websiteConstraints()
           setConstraints()
    }
    
    fileprivate func backgroundCardConstraints() {
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    fileprivate func usernameConstraints() {
        username.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 20).isActive = true
        username.heightAnchor.constraint(equalToConstant: 25).isActive  = true
        username.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 30).isActive = true
    }
    
    fileprivate func nameConstraints() {
        name.topAnchor.constraint(equalTo: username.bottomAnchor , constant:10).isActive = true
        name.heightAnchor.constraint(equalToConstant: 25).isActive = true
        name.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 30).isActive = true
    }

    
    fileprivate func websiteImageConstraints() {
        websiteImage.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 20).isActive = true
        websiteImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        websiteImage.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -30).isActive = true
        websiteImage.widthAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    fileprivate func websiteConstraints() {
//        website.centerYAnchor.constraint(equalTo: websiteImage.centerYAnchor).isActive = true
//        website.leadingAnchor.constraint(equalTo: websiteImage.trailingAnchor, constant: 4).isActive = true
//        website.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -10).isActive = true
    }
    
    fileprivate func setConstraints(){
        voteCount.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 30).isActive = true
        voteCount.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -30).isActive = true
        
        vote.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -30).isActive = true
        vote.leadingAnchor.constraint(equalTo: voteCount.trailingAnchor, constant: 10).isActive = true
        
        commentCount.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -30).isActive = true
        commentCount.leadingAnchor.constraint(equalTo: vote.trailingAnchor, constant: 30).isActive = true
        
        comment.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -30).isActive = true
        comment.leadingAnchor.constraint(equalTo: commentCount.trailingAnchor, constant: 10).isActive = true
        
        share.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -30).isActive = true
        share.leadingAnchor.constraint(equalTo: comment.trailingAnchor, constant: 30).isActive = true
        
    }
    
    func set(res:User) {
        username.text = String("Sample UI")
        name.text = String("By itsnitigya")
        websiteImage.image = UIImage(named: "UI")
        website.text = String(res.website)
        voteCount.text = String(50)
        commentCount.text = String(20)
//        username.text = String(res.username)
//        name.text = String(res.name)
//        websiteImage.image = UIImage(named: "UI")
//        website.text = String(res.website)
//        voteCount.text = String(50)
//        commentCount.text = String(20)
    }

}

