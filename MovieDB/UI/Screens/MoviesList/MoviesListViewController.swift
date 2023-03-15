//
//  MoviesListViewController.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import UIKit

class MoviesListViewController: UIViewController {
  
  @IBOutlet weak var tableview: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableview.dataSource = self
    tableview.delegate = self
  }
  
}

extension MoviesListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    <#code#>
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    <#code#>
  }
  
  
}

extension MoviesListViewController: UITableViewDelegate {
  
}
