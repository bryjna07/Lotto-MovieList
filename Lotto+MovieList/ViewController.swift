//
//  ViewController.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/23/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goLottoVC(_ sender: UIButton) {
        let vc = LottoViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func goMovieVC(_ sender: UIButton) {
        let vc = MovieViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

