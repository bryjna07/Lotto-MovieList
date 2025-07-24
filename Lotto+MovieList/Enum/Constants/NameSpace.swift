//
//  NameSpace.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/24/25.
//

import Foundation

enum URL {
    case lotto
    case movie
    
    var baseURL: String {
        switch self {
        case .lotto:
            return "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
        case .movie:
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
        }
    }
}

enum MovieAPI {
    static let movieAPIKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String else {
            fatalError("API 키가 설정되지 않았습니다.")
        }
        return key
    }()
    
    static func movieURL(date: String) -> String {
        return "\(URL.movie.baseURL)key=\(movieAPIKey)&targetDt=\(date)"
    }
}
