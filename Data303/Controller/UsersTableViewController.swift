//
//  UsersTableViewController.swift
//  Data303
//
//  Created by carlos on 18/3/18.
//  Copyright © 2018 carlos. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

    var users = [User]()

    struct StoryBoard
    {
        static let cellIdentify = "userIdentify"
    }

    struct Server
    {
        static let UserResource = "http://www.filltext.com/?rows=100&fname=%7BfirstName%7D&lname=%7BlastName%7D&city=%7Bcity%7D&pretty=true"
    }

    // MARK: - Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
            makeRequest(url: Server.UserResource)
            { [weak self] (data, response, error) -> Void in
                if data != nil {
                    let publicidadResponseArray = self?.parserResponse(data: data) ?? []
                    for dictionary in publicidadResponseArray {
                        let user = User(dictionary: dictionary as NSDictionary)
                        self?.users.append(user)
                    }
                    DispatchQueue.main.sync {
                        self?.tableView.reloadData()
                    }
                }
            }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.cellIdentify, for: indexPath)
        return cell
    }

    // MARK: - Parsers and requests issues

    func makeRequest(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = prepareTask(url: url, completionHandler: completionHandler)
        task.resume()
    }

    func prepareTask(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let requestURL = NSURL(string:"\(url)")!
        let request = NSMutableURLRequest(url: requestURL as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        return session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
    }

    func parserResponse(data: Data?) -> Array<Dictionary<String, AnyObject>> {
        do {
            if let jsonDict = try JSONSerialization.jsonObject(with: data!, options: [])
                as? Array<Dictionary<String, AnyObject>> {
                return jsonDict
            } else {
                print("Error to parser body")
                return []
            }
        } catch _ {
            print("Error to convert data of body")
            return []
        }
    }

}
