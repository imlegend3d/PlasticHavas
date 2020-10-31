//
//  NetworkCall.swift
//  PlasticHavas
//
//  Created by David on 2020-10-30.
//

//import Foundation
//
//@objc class RedditRequest: NSObject {
//         //API url address to call
//    private let urlString = "https://www.reddit.com/.json"
//
////    @objc func fetchRedditData(completion: @escaping (Result<[RedditPost], Error>)->Void){
//    @objc func fetchRedditData(completion: @escaping ([RedditPost])->Void){
//        print(urlString)
//        guard let url = URL(string: urlString) else {return}
//
//        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let err = error {
//                print("Error", err)
//                return
//            }
//
//            guard let jsonData = data else {print("Error, no data available"); return}
//
//            //If Responso Ok and no Error = Succesfull network data fetching
//
//            //Parse jsonData
//            do {
//                let redditResponse = try JSONDecoder().decode(RedditResponse.self, from: jsonData)
//
//                let posts = redditResponse.data.children.data
////                 completion(.success(posts))
//                completion(posts)
//            } catch let jsonErr {
//                print("Error", jsonErr)
////                completion(.failure(jsonErr))
//            }
//        }
//        dataTask.resume()
//    }
//}
