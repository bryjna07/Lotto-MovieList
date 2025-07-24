//
//  MovieCell.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/23/25.
//

import UIKit
import SnapKit

final class MovieCell: UITableViewCell {
    
    private let rankNumberView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
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
}

extension MovieCell: ConfigureUI {
    func configureUIWithData() {
        guard let movie else { return }
        numberLabel.text = movie.rank
        nameLabel.text = movie.movieNm
        dateLabel.text = movie.openDt
    }
    
    func configureUI() {
        backgroundColor = .lightGray
        selectionStyle = .none
        
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
