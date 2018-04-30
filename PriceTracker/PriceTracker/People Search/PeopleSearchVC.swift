//
//  PeopleSearchVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class PeopleSearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var results: [String] = []
    var currentResults : [String] = [] // update table
    var emailToSend : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        getUserEmails()
    }
    
    func getUserEmails() {
        var userEmails: [String] = []
        let dbRef = Database.database().reference()
        dbRef.child(firUsersNode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let userids = snapshot.value as? [String:AnyObject] {
                    for key in userids.keys {
                        userEmails.append(userids[key]![firEmailNode] as! String)
                    }
                    self.results = userEmails
                    self.currentResults = self.results
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? PeopleSearchTableViewCell else {
            return UITableViewCell()
        }
        cell.emailLabel.text = currentResults[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        emailToSend = currentResults[indexPath.row]
        performSegue(withIdentifier: "search-usercopy", sender: self)
    }
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentResults = results
            tableView.reloadData()
            return
        }
        currentResults = results.filter({ user -> Bool in
            user.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VCHeadedTo = segue.destination as? UserCopyVC {
            VCHeadedTo.emailFromPeopleSearch = emailToSend
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
