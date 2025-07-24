//
//  LottoViewController.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

final class LottoViewController: UIViewController {
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "회차를 선택해주세요"
        tf.font = .systemFont(ofSize: 20)
        tf.textAlignment = .center
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.systemGray5.cgColor
        tf.layer.cornerRadius = 4
        tf.inputView = pickerView
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
        label.text = "1181회 당첨 결과"
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
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    //MARK: - Data
    private var roundNumbers: [Int] = []

    private var numArray: [Int] = []
    
    private var lotto: Lotto? {
        didSet {
            guard let lotto else { return }
            dateLabel.text = lotto.drwNoDate
            numArray = []
            numArray.append(lotto.drwtNo1)
            numArray.append(lotto.drwtNo2)
            numArray.append(lotto.drwtNo3)
            numArray.append(lotto.drwtNo4)
            numArray.append(lotto.drwtNo5)
            numArray.append(lotto.drwtNo6)
            numArray.append(lotto.bnusNo)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentNumber = getCurrentNumber()
        roundNumbers = Array(1...currentNumber).reversed()
        
        configureHierarachy()
        configureLayout()
        configureView()
        callRequest(no: "\(currentNumber)")
    }
    
    //MARK: - API
    func getCurrentNumber() -> Int {
        guard let first = DateFormatter.krDateFormatter.date(from: "20021207") else { return 1 }
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul") ?? .current
        let interval = calendar.dateComponents([.day], from: first, to: Date()).day ?? 0
        
        let currentNumber = 1 + interval / 7
        
        return currentNumber
    }
    
    private func callRequest(no: String = "1181") {
        let url = "\(URL.lotto.baseURL)&drwNo=\(no)"
  
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let lotto):
                DispatchQueue.main.async { [weak self] in
                    self?.lotto = lotto
                    self?.makeLottoStack()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func makeLottoStack() {
        lottoStackView.arrangedSubviews.forEach {
            lottoStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
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
        updateLabel(number: roundNumbers[row])
        callRequest(no: "\(roundNumbers[row])")
        textField.resignFirstResponder()
    }
    
    private func updateLabel(number: Int) {
        textField.text = "\(number)"
        resultLabel.text = "\(number)회 당첨 결과"
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
    }
}
