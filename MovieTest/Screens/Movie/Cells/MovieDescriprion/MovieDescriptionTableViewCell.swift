//
//  MovieDescriptionTableViewCell.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import UIKit

class MovieDescriptionTableViewCell: UITableViewCell {
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    func display(entity: HomeEntity.View.MovieEntity) {
        overviewLabel.text = entity.description
        releaseDateLabel.text = Constants.release + " " + entity.releaseDate
    }
}
