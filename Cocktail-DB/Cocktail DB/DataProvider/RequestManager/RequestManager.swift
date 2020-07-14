//
//  RequestManager.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 10.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation
import Alamofire

struct RequestManager: DataProvider {
    
    private func alamofireRequest<T: Decodable>(with url: String, parameters: Parameters, model: T.Type, completion: @escaping (T) -> Void) {
        AF.request(url, method: .get, parameters: parameters).validate().responseDecodable(of: model.self) { response in
            guard let drinks = response.value else { return }
            completion(drinks)
        }
    }
    
    func loadDrinksCategories(completion: @escaping (DrinksCategoryModel) -> Void) {
        let url = RequestManagerConstants.baseURL + RequestManagerConstants.drinks
        let parameters: Parameters = ["c" : "list"]
        
        alamofireRequest(with: url, parameters: parameters, model: DrinksCategoryModel.self) { response in
            completion(response)
        }
    }

    func loadDrinks(with name: String, completion: @escaping (DrinksModel) -> Void) {
        let url = RequestManagerConstants.baseURL + RequestManagerConstants.filters
        let parameters: Parameters = ["c" : name]
        
        alamofireRequest(with: url, parameters: parameters, model: DrinksModel.self) { response in
            completion(response)
        }
    }
    
}
