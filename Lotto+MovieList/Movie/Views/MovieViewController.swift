//
//  MovieViewController.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/23/25.
//

import UIKit
import SnapKit

final class MovieViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색해보세요"
        searchBar.searchBarStyle = .prominent
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MovieCell.self, forCellReuseIdentifier: MovieCell.id)
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarachy()
        configureLayout()
        configureView()
        movieList = MovieInfo.movies
    }
}

extension MovieViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieList.shuffle()
        tableView.reloadData()
        view.endEditing(true)
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.id, for: indexPath) as! MovieCell
        cell.movie = movieList[indexPath.row]
        return cell
    }
}


extension MovieViewController: ViewDesignProtocol {
    func configureHierarachy() {
        [
            searchBar,
            tableView
        ].forEach {
            view.addSubview($0)
        }
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .gray
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
}
