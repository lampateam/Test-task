//
//  HomeTableViewDataSource.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import UIKit

class HomeTableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var data: [HomeEntity.View.MovieEntity] = []
    
    var selectedHandler: ((_ id: Int) -> Void)?
    var loadMoreDataHandler: (() -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(MovieTableViewCell.self, for: indexPath)
        cell.display(entity: data[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedHandler?(data[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            loadMoreDataHandler?()
        }
    }
}
