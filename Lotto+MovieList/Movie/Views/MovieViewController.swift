//
//  MovieViewController.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

final class MovieViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색예시 : 20201012"
        searchBar.searchBarStyle = .prominent
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(MovieCell.self, forCellReuseIdentifier: CellType.movie.id)
        table.backgroundColor = .clear
        table.rowHeight = 60
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarachy()
        configureLayout()
        configureView()
        callBoxOffice(date: getYesterDay())
    }
    
    func getYesterDay() -> String {
        let now = Date()
        let yesterDay = now.calculateYesterDay()
        guard let yesterDay, let str = yesterDay.dateToString() else { return "20201012" }
        return str
    }
    
    func callBoxOffice(date: String) {
        let url = MovieAPI.movieURL(date: date)
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: BoxOffice.self) { response in
                switch response.result {
                case .success(let value):
                    DispatchQueue.main.async { [weak self] in
                        self?.movieList = value.boxOffice.movieList
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    self.showAlert(title: "서버오류", message: "다시 시도해주세요")
                    print(error)
                }
            }
    }
}

extension MovieViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            showAlert(title: "오류", message: "검색어를 입력해주세요")
            return
        }
        guard let date = Int(text) else {
            showAlert(title: "오류", message: "숫자를 입력해주세요\nEx)20201012")
            return
        }
        callBoxOffice(date: "\(date)")
        tableView.reloadData()
        view.endEditing(true)
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellType.movie.id, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
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
    }
}
