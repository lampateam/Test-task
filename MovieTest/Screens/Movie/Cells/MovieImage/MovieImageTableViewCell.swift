//
//  MovieImageTableViewCell.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import UIKit

class MovieImageTableViewCell: UITableViewCell {
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    private var cornerRadius: CGFloat = 12
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        posterImage.viewCorner(cornerRadius)
    }
    
    func display(entity: HomeEntity.View.MovieEntity) {
        movieNameLabel.text = entity.name
        ratingLabel.text = String(entity.popularity)
        
        guard let url = URL(string: entity.posterURL) else { return }
        posterImage.setImage(from: url)
    }
}
