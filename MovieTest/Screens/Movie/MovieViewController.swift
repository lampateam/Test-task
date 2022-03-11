//
//  MovieViewController.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import UIKit

protocol MovieViewControllerProtocol: AnyObject {
    func display(data: HomeEntity.View.MovieEntity)
    func showError(error: Error)
    func setupBlockScreen(flag: Bool)
}

class MovieViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addToFavoriteButton: UIButton!
    
    // MARK: - Properties
    private var presenter: MoviePresenterProtocol!
    private let dataSource = MovieTableViewDataSource()
    var id: Int?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MoviePresenter(view: self, id: id)
        
        setupViews()
        presenter.getData()
    }
    
    // MARK: - UI
    private func setupViews() {
        setupCornerRadius()
        setupTableView()
    }
    
    private func setupCornerRadius() {
        addToFavoriteButton.viewCorner()
    }
    
    private func setupTableView() {
        tableView.registerCell(MovieImageTableViewCell.self)
        tableView.registerCell(MovieDescriptionTableViewCell.self)
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.backgroundColor = .clear
    }
    
    // MARK: - IBActions
    @IBAction func addToFavoriteButtonPressed(_ sender: Any) {
        
    }
}

extension MovieViewController: MovieViewControllerProtocol {
    func display(data: HomeEntity.View.MovieEntity) {
        dataSource.data = data
        tableView.reload()
    }
    
    func showError(error: Error) {
        showAlert(with: error, message: nil, title: Constants.error)
    }
    
    func setupBlockScreen(flag: Bool) {
        blockScreenViewStart(flag: flag)
    }
}
