//
//  SearchViewController.swift
//  DREKTORE
//
//  Created by Joshua on 3/3/17.
//  Copyright © 2017 Joshua. All rights reserved.
//

import UIKit

public class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var results = [Student]()
    var searchActive: Bool = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let sharedInstance =  DataContainer.sharedInstance
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUI), name: NSNotification.Name(rawValue: "SearchResultsReceived"), object: nil)
        
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func refreshUI() {
        results = DataContainer.sharedInstance.students
        DispatchQueue.main.async {self.tableView.reloadData()}
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
        self.searchBar.endEditing(true)
        if searchText != "" {
            searchStudents(withWord: searchText)
            //send request
        }
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = sharedInstance.students.count
        print("*student count:\(count)")
        return results.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StudentViewCell = tableView.dequeueReusableCell(withIdentifier: "StudentViewCell")! as UITableViewCell as! StudentViewCell
        let index = indexPath.row
        let currentStudent = sharedInstance.students[index]
        cell.studentPhoto.image = UIImage(named: "placeholderYellow")
        cell.studenNameLabel.text = currentStudent.firstName + " " + currentStudent.lastName
        cell.studentEmailLabel.text = currentStudent.email
        cell.studentPhoneLabel.text = currentStudent.phoneNumber
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = StudentDetailsViewController()
        let selectedStudent = sharedInstance.students[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
        destination.studentInfo = selectedStudent
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

