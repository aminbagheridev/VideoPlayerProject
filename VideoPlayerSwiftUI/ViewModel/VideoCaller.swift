//
//  VideoCaller.swift
//  VideoPlayerSwiftUI
//
//  Created by Amin  Bagheri  on 2022-08-24.
//

import Foundation

class VideoCaller {
    
    let urlString = "http://localhost:4000/videos"
    
    func getVideos(completion: @escaping(Result<Video, VideoCallerError>) -> Void) {
        // Converting the url string to actual URL for use.
        guard let url = URL(string: urlString) else {
            completion(.failure(VideoCallerError.failedToConvertURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { print(error?.localizedDescription as Any); return }
            
            guard let data = data else {
                completion(.failure(VideoCallerError.apiReturnedNoData))
                return
            }

        }.resume()
        
    }
}
