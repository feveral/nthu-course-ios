//
//  CourseSearchController.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/10/3.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import UIKit

class CourseSearchController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    // Mark: Properties
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    var tableStatus = CourseSearchTableStatus()

    // Protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableStatus.cellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableStatus.buildCell(tableView, indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableStatus.clickCell(self, indexPath)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
    
    // Methods
    
    func initialSearchView() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        self.navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        initialSearchView()
        CourseService.getCourseByFilter(department: "CS", type: 5).done { courses in
            self.tableStatus.addCourses(courses)
            self.tableView.reloadData()
        }.catch { error in
            print(error)
        }
    }
}
