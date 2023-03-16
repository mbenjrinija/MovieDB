//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Mouad Bj on 16/3/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {

  var viewModel: MovieDetailsViewModel!
  
  @IBOutlet weak var poster: UIImageView!

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var genresLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  
  @IBOutlet weak var mainView: UIView!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  
  var bag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    viewModel.loadDetails()
  }
  
  func setup() {
    viewModel.$movieDetails
      .map(\.value)
      .replaceError(with: nil)
      .compactMap { $0 }
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] movieDetail in
        if let posterString = movieDetail.posterPath,
           let posterURL = URL(string: "\(Constants.API.imagesBaseUrl)\(posterString)") {
          self?.poster.load(url: posterURL, placeholder: nil)
        }
        self?.titleLabel.text = movieDetail.title ?? "-"
        self?.descLabel.text = movieDetail.overview ?? "-"
        self?.genresLabel.text = movieDetail.genres?
          .compactMap { $0.name }.joined(separator: ", ") ?? "-"
      }).store(in: &bag)
    
    viewModel.$movieDetails
      .map(\.isLoading)
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] isLoading in
        self?.showLoading(isLoading)
      }).store(in: &bag)
    
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  @IBAction func onBackTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  func showLoading(_ show: Bool) {
    if show {
      loadingIndicator.startAnimating()
    } else {
      loadingIndicator.startAnimating()
    }
    mainView.isHidden = show
  }
  
}
