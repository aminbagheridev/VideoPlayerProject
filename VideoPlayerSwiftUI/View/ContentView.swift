//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI

struct ContentView: View {
    
    let videoCaller = VideoCaller.shared
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                videoCaller.getVideos { result in
                    switch result {
                    case.success(let videos):
                        print("VIDEO URL: ", videos.first?.hlsURL)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
