//
//  ViewDesignProtocol.swift
//  SeSAC7WEEK4CodeBase
//
//  Created by YoungJin on 7/22/25.
//

import Foundation
import UIKit

protocol ViewDesignProtocol: AnyObject {
    func configureHierarachy()
    func configureLayout()
    func configureView()
}

@objc protocol ConfigureUI: AnyObject {
    @objc optional func configureUIWithData()
    func configureUI()
}
