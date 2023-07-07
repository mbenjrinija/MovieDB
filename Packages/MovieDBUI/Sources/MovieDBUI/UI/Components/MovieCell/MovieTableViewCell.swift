//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Mouad Bj on 16/3/2023.
//

import UIKit
import MovieDBCore

struct MovieCellViewModel: Hashable {
  var movie: Movie
  var posterURL: URL?
}

class MovieTableViewCell: UITableViewCell {
  
  var viewModel: MovieCellViewModel! {
    didSet {
      setup()
    }
  }
  
  @IBOutlet weak var poster: UIImageView!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var year: UILabel!
  @IBOutlet weak var rating: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func setup() {
    if let posterURL = viewModel.posterURL {
      poster.load(url: posterURL, placeholder: nil)
    }
    let movie = viewModel.movie
    title.text = movie.title ?? "-"
    year.text = movie.releaseDate ?? "-"
    rating.text = "⭐ \(Int(movie.voteAverage ?? 0))/100"
  }
}
