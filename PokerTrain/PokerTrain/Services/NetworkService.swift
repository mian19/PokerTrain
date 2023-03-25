////
////  NetworkService.swift
////  TraidingSimulator
////
////  Created by Kyzu on 12.02.23.
////
//
//import Foundation
//
//class NetworkService {
//    
//    func request( ) {
//        let parameters = self.prepareParameters()
//        let url = self.url(params: parameters)
//        
//        var request = URLRequest(url: url)
//      //  request.allHTTPHeaderFields = prepareHeader()
//        request.httpMethod = "get"
//        let task = createDataTask(from: request)
//        task.resume()
//    }
//    
////    private func prepareHeader() -> [String: String]? {
////        var headers = [String: String]()
////        headers["Authorization"] = "Client-ID qHBA_Snp5lU1DTxfo69ymH05FVOUITIaryVNos3rvH0"
////        return headers
////    }
//    
//    private func prepareParameters() -> [String: String] {
//        var parameters = [String: String]()
//        parameters["user_id"] = "10054"
//        parameters["token"] = "55b9a408-9277-11ed-a1eb-0242ac120002"
////        parameters["per_page"] = "30"
////        parameters["orientation"] = "portrait"
//        return parameters
//    }
//    
//    private func url(params: [String : String]) -> URL {
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "bionn.space"
//        components.path = "/api/v2/trade/history"
//        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
//        return components.url!
//    }
//    
//    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
//        return URLSession.shared.dataTask(with: request) { (data, response, error) in
//            DispatchQueue.main.async {
//                completion(data, error)
//            }
//        }
//    }
//}
