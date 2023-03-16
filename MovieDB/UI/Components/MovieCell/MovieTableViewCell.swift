//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Mouad Bj on 16/3/2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
  
  var movie: Movie! {
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
    if let posterString = movie.posterPath,
       let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterString)") {
      poster.load(url: posterURL, placeholder: nil)
    }
    title.text = movie.title ?? "-"
    year.text = movie.releaseDate ?? "-"
    rating.text = "⭐ \(Int(movie.voteAverage ?? 0))%"
  }
}
