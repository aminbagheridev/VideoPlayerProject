//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    
    let videoCaller = VideoCaller.shared
    
    @State var placeholderVideoUrl: URL = Bundle.main.url(forResource: "loading", withExtension: "mp4")!
    
    var body: some View {
        
        NavigationView {
            VStack {
                LoopingPlayer(videoUrl: placeholderVideoUrl)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.3)
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        
                    }
                }.frame(height: UIScreen.main.bounds.height * 0.7)
            }.onAppear {
                videoCaller.getVideos { result in
                    switch result {
                    case.success(let videos):
                        if let urlString = videos.first?.hlsURL, let url = URL(string: urlString) {
                            placeholderVideoUrl = url
                            print("VIDEO URL: ", url)

                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            .navigationTitle("Video Player")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
