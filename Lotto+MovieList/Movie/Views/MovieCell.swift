//
//  MovieCell.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/23/25.
//

import UIKit
import SnapKit

final class MovieCell: UITableViewCell {
    
    static let id = "MovieCell"
    
    private let rankNumberView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "dateeeee"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    var movie: Movie? {
        didSet {
            configureUIWithData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUIWithData() {
        guard let movie else { return }
        nameLabel.text = movie.title
        dateLabel.text = movie.releaseDate.formatDate()
    }
    
    private func configureUI() {
        backgroundColor = .lightGray
        
        rankNumberView.addSubview(numberLabel)
        
        [
            rankNumberView,
            nameLabel,
            dateLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        numberLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        rankNumberView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.width.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.leading.equalTo(rankNumberView.snp.trailing).offset(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(82)
        }
    }
}
