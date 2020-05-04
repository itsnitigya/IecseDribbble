//
//  Networking.swift
//  Users
//

import Foundation
import Disk

enum UserError:Error{
    case NoDataAvailable
    case CanNotProcessData
}
struct Networking{
    static let sharedInstance = Networking()
    let session = URLSession.shared
    
    let userURL = "https://jsonplaceholder.typicode.com/users"
    
    func getUsers(completion: @escaping(Result<[User],UserError>)->Void) {
        let UserURL=URL(string: userURL)!
        let dataTask=session.dataTask(with: UserURL){data,_,_ in
            guard let jsonData = data else{
                completion(.failure(.NoDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                //new code starts
                try? Disk.save(jsonData, to: .caches, as: "users.json")
                //new code ends
                let userResponse = try decoder.decode([User].self,from:jsonData)
                completion(.success(userResponse))
            }
            catch{
                completion(.failure(.CanNotProcessData))
            }
        }
        dataTask.resume()
    }
}

