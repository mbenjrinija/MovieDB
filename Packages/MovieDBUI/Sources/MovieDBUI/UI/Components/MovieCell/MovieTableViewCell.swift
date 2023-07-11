//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Mouad Bj on 16/3/2023.
//

import UIKit
import MovieDBCore

class MovieTableViewCell: UITableViewCell {
  
  var viewModel: MovieCellViewModel! {
    didSet { setup() }
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
    poster.load(url: viewModel.posterURL, placeholder: nil)
    title.text = viewModel.title
    year.text = viewModel.releaseDate
    rating.text = viewModel.rating
  }
}
