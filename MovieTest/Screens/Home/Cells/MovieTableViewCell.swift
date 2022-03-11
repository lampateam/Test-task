//
//  MovieTableViewCell.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImage.image = nil
    }

    func display(entity: HomeEntity.View.MovieEntity) {
        movieName.text = entity.name
        descriptionLabel.text = entity.description
        releaseDateLabel.text = Constants.release + entity.releaseDate
        
        guard let url = URL(string: entity.posterURL) else { return }
        posterImage.setImage(from: url)
    }
}
