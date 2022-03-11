//
//  MovieTableViewDataSource.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import UIKit

class MovieTableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var data: HomeEntity.View.MovieEntity?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieEntity.CellsType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = MovieEntity.CellsType(rawValue: indexPath.row), let data = data else { return UITableViewCell() }
        
        switch type {
        case .image:
            let cell = tableView.dequeueCell(MovieImageTableViewCell.self, for: indexPath)
            cell.display(entity: data)
            cell.selectionStyle = .none
            return cell
        case .description:
            let cell = tableView.dequeueCell(MovieDescriptionTableViewCell.self, for: indexPath)
            cell.display(entity: data)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}
