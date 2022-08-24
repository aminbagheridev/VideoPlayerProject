//
//  VideoCaller.swift
//  VideoPlayerSwiftUI
//
//  Created by Amin  Bagheri  on 2022-08-24.
//

import Foundation

class VideoCaller {
    
    private init() {}
    static let shared = VideoCaller()
    
    let urlString = "http://localhost:4000/videos"
    
    func getVideos(completion: @escaping(Result<Video, VideoCallerError>) -> Void) {
        // Converting the url string to actual URL for use.
        guard let url = URL(string: urlString) else {
            completion(.failure(VideoCallerError.failedToConvertURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Making sure errors don't exist.
            guard error == nil else { print(error?.localizedDescription as Any); return }
            
            // Making sure status code is correct
            if let statusCode = response?.getStatusCode() {
                print("Recieved status code")
                guard statusCode == 200 else {
                    completion(.failure(VideoCallerError.incorrectStatusCode))
                    return

                }
            }
            
            // Making sure data exists
            guard let data = data else {
                completion(.failure(VideoCallerError.apiReturnedNoData))
                return
            }
            
            // Turning JSON Data to actual list of video objects using a do-catch block to catch errors.
            let decoder = JSONDecoder()

            do {
                let videos = try decoder.decode(Video.self, from: data)
                completion(.success(videos))
                print(videos)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
