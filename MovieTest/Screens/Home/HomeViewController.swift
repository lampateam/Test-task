//
//  HomeViewController.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func display(data: [HomeEntity.View.MovieEntity])
    func showError(error: Error)
    func setupBlockScreen(flag: Bool)
}

class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var presenter: HomePresenterProtocol! 
    private let dataSource = HomeTableViewDataSource()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomePresenter(view: self)
        
        setupViews()
        presenter.getData(nextPage: false)
    }
    
    // MARK: - UI
    private func setupViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        setupDataSource()
        
        tableView.registerCell(MovieTableViewCell.self)
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.backgroundColor = .clear
    }
    
    private func setupDataSource() {
        dataSource.selectedHandler = { [weak self] id in
            guard let self = self else { return }
            let vc = MovieViewController.fromStoryboard
            vc.id = id
            self.pushToVC(vc, animated: true)
        }
        
        dataSource.loadMoreDataHandler = { [weak self]  in
            guard let self = self else { return }
            self.presenter.getData(nextPage: true)
        }
    }
    
    // MARK: - IBActions
    @IBAction func segmentControlChangedValue(_ sender: UISegmentedControl) {
        guard let state = HomeEntity.HomeState(rawValue: sender.selectedSegmentIndex) else { return }
        
        if !self.dataSource.data.isEmpty {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        
        presenter.state = state
        presenter.moviesList = HomeEntity.Response.ListMovies()
        presenter.getData(nextPage: false)
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func display(data: [HomeEntity.View.MovieEntity]) {
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
