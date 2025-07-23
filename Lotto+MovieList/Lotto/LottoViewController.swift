//
//  LottoViewController.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/23/25.
//

import UIKit
import SnapKit

final class LottoViewController: UIViewController {
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "회차를 선택해주세요"
        tf.font = .systemFont(ofSize: 20)
        tf.textAlignment = .center
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.systemGray5.cgColor
        tf.layer.cornerRadius = 4
        tf.clipsToBounds = true
        return tf
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020-05-30 추첨"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "913회 당첨결과"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var lottoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let pickerView = UIPickerView()
    private let roundNumbers = Array(1...1181)
    
    var numBox: [Int] = Array(1...45)
    
    var numArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarachy()
        configureLayout()
        configureView()
        makeLotto()
    }
    
    private func makeLotto() {
        lottoStackView.arrangedSubviews.forEach {
            lottoStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        numArray = numBox.shuffled().prefix(7).sorted()
        
        numArray[0...5].map {
            LottoBallView(title: String($0))
        }.forEach {
            lottoStackView.addArrangedSubview($0)
        }
        lottoStackView.addArrangedSubview(LottoBallView(title: "+"))
        lottoStackView.addArrangedSubview(LottoBallView(title: String(numArray[6])))
    }
}

extension LottoViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roundNumbers.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(roundNumbers[row])"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = "\(roundNumbers[row])"
        makeLotto()
        textField.resignFirstResponder()
    }
}


extension LottoViewController: ViewDesignProtocol {
    
    func configureHierarachy() {
        [
            textField,
            infoLabel, dateLabel,
            dividerView,
            resultLabel,
            lottoStackView
        ].forEach {
            view.addSubview($0)
        }
        
    }
    
    func configureLayout() {
        textField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(30)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        lottoStackView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        pickerView.dataSource = self
        pickerView.delegate = self
        textField.inputView = pickerView
    }
}
