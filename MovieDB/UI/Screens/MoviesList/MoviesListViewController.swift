//
//  MoviesListViewController.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import UIKit
import Combine

class MoviesListViewController: UIViewController {
  
  var viewModel: MoviesListViewModel!
  
  @IBOutlet weak var tableview: UITableView!
  var dataSource: UITableViewDiffableDataSource<Int, Movie>!
  let refreshControl = UIRefreshControl()
  var bag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    viewModel.refreshMovies()
  }
  
  func setup() {
    // configure tableview and it dataSource
    tableview.register(cellType: MovieTableViewCell.self)
    dataSource = UITableViewDiffableDataSource(tableView: tableview,
     cellProvider: { tableView, indexPath, item -> MovieTableViewCell in
      let cell: MovieTableViewCell = self.tableview.dequeueReusableCell(for: indexPath)
      cell.movie = item
      return cell
    })
    tableview.delegate = self
    tableview.dataSource = dataSource
    
    // bind publisher with tabelview
    viewModel.movies
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] movies in
        print(movies)
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        snapshot.appendSections([0])
        snapshot.appendItems(movies)
        self?.dataSource.apply(snapshot)
      }).store(in: &bag)
    // config loading animation
    viewModel.isLoading
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] isLoading in
        if isLoading {
          self?.tableview.showLoading()
        }
      }).store(in: &bag)
      
    // config pull to refresh
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    tableview.addSubview(refreshControl)
  }
  
  @objc func refresh(_ sender: AnyObject) {
    refreshControl.endRefreshing()
    viewModel.refreshMovies()
  }
  
}

extension MoviesListViewController: UITableViewDelegate {
  // handle pagination on scroll down
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard tableview.numberOfRows(inSection: 0) - 1 == indexPath.row else { return }
    viewModel.loadNextMoviesPage()
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 200 }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let movie = dataSource.itemIdentifier(for: indexPath) else { return }
    viewModel.didSelect(movie: movie)
  }
}
