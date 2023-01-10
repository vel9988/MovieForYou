//
//  MyFavouritesViewController.swift
//  MovieForYou
//
//  Created by Dmitryi Velko on 22.12.2022.
//

import UIKit

class MyFavouritesViewController: UIViewController {
    
    private var titles = [TitleItem]()
    
    // MARK: - Subviews
    private let favouritesTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favourites"
        view.addSubview(favouritesTable)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        fetchLocalStorageForFavourites()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("add"),
                                               object: nil,
                                               queue: nil) { _ in
            self.fetchLocalStorageForFavourites()
        }
        
        favouritesTable.delegate = self
        favouritesTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favouritesTable.frame = view.bounds
    }
    
    // MARK: - Private method
    private func fetchLocalStorageForFavourites() {
        DataPersistenceManager.shared.fetchingTitlesFromDatabase { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.favouritesTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

// MARK: - UITableViewDelegate
extension MyFavouritesViewController: UITableViewDelegate {
    
}
// MARK: - UITableViewDataSource
extension MyFavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        let title = titles[indexPath.row]
        let titleName = title.originalTitle ?? title.originalName ?? ""
        cell.configure(with: TitleViewModel(titleName: titleName,
                                            posterURL: title.posterPath ?? "",
                                            rating: title.voteAverage))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteTitle(with: titles[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    self?.titles.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        let titleName = title.originalTitle ?? title.originalName ?? ""
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName,
                                                             youTubeVideoTrailer: videoElement,
                                                             overview: title.overview ?? "",
                                                             rating: title.voteAverage))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
