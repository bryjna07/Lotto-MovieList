//
//  LottoBallView.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/23/25.
//

import UIKit
import SnapKit

final class LottoBallView: UIView {
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.bounds.width / 2
        clipsToBounds = true
    }
    
    init(title: String) {
        super.init(frame: .zero)
        numberLabel.text = title
        if let number = Int(title) {
            switch number {
            case 41...45:
                backgroundColor = .green
            case 31...40:
                backgroundColor = .gray
            case 21...30:
                backgroundColor = .red
            case 11...20:
                backgroundColor = .blue
            case 1...10:
                backgroundColor = .yellow
            default:
                backgroundColor = .black
            }
        } else {
            numberLabel.textColor = .black
            backgroundColor = .white
        }
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(self.snp.width)
        }
    }
}
