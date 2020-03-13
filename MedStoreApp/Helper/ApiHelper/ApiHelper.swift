//
//  ApiHelper.swift
//  MedStoreApp
//
//  Created by Paresh Prajapati on 13/03/20.
//  Copyright © 2020 SolutionAnalysts. All rights reserved.
//

import Foundation
import RxSwift

struct Resource<T: Decodable> {
    let url: URL
}

class ApiHelper: NSObject {
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T? in
                return try? JSONDecoder().decode(T.self, from: data)
        }.asObservable()
    }
}
