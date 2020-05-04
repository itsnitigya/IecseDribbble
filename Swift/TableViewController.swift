//
//  TableViewController.swift
//  Users
//
//  Created by Dhruvik Chevli on 28/03/20.
//

import UIKit
import Disk

class TableViewController: UITableViewController,PassingUser {
    
    var users = [User](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    func passUser(user: User) {
        self.users.append(user)
        self.tableView.reloadData()
    }
    
    @objc func goToSecondScreen(){
        let sampleScreen = SampleScreen()
        sampleScreen.delegate = self
        self.navigationController?.present(sampleScreen, animated: true)
        view.snapshotView(afterScreenUpdates: true)
    }

    fileprivate func setUpTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.title = "Feed"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToSecondScreen))
        let logout = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(goToFirstScreen))
        self.navigationItem.rightBarButtonItem = add
        self.navigationItem.leftBarButtonItem = logout
        tableView.register(UserCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.systemGroupedBackground
        tableView.rowHeight = 250
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func someHandler(alert: UIAlertAction!) {
        let loginScreen = LoginScreen()
        loginScreen.modalPresentationStyle = .fullScreen
        present(loginScreen , animated: true)
    }
    
    @objc func goToFirstScreen(){
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to logout?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: someHandler))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            users = try Disk.retrieve("users.json", from: .caches, as: [User].self)
        }
        catch{
            fetchData()
        }
        tableView.reloadData()
        setUpTableView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UserCell
        cell.layer.cornerRadius = 15
        let user = users[indexPath.row]
        cell.set(res : user)
        return cell
    }

}

extension TableViewController {
    
    func fetchData(){
        Networking.sharedInstance.getUsers{[weak self] result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let usersRes):
                self?.users = usersRes
            }
        }
    }
}



