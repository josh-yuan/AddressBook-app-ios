//
//  SearchViewController.swift
//  DREKTORE
//
//  Created by Joshua on 3/3/17.
//  Copyright © 2017 Joshua. All rights reserved.
//

import UIKit

public class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var searchActive: Bool = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
    }

    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchBar.endEditing(true)
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        let searchInput: String = searchBar.text ?? ""
        //remove leading and trailing whitespaces
        let searchText = searchInput.trimmingCharacters(in: .whitespaces)
        print("*\(searchText)*")
        self.searchBar.endEditing(true)
        if searchText != "" {
            searchStudents(withWord: searchText)
            //send request
        }
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        //self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return 0
        }
        return 2//data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell")! as UITableViewCell
        
        return cell
    }

    
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

