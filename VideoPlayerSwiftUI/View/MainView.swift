//
//  MainView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVKit
import Parma



struct MainView: View {
    
    @State var vidIndex: Int = 0 //the index of the video being played, in the apiVideos array
    @State var apiVideos: Video?
    let videoCaller = VideoCaller.shared // the network request
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "loading", withExtension: "mp4")!)
    @State var isPlaying = false
    @State var showingControls = false
    @State var sliderValue : Float = 0
    
    var body: some View {
        NavigationView {
            VStack{
                
                ZStack{
                    
                    VideoPlayer(player: $player)
                    
                    if self.showingControls{
                        
                        // show controls over the video player, the controls have binding to properties on this view.
                        Controls(player: self.$player, isplaying: self.$isPlaying, pannel: self.$showingControls, value: self.$sliderValue, vidIndex: $vidIndex, videos: self.$apiVideos)
                    }
                    
                }
                //when the index changes, set it to a new video, accordingly.
                .onChange(of: vidIndex, perform: { newValue in
                    if apiVideos != nil {
                        self.player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: apiVideos![vidIndex].hlsURL)! ) )
                        self.player.pause()
                        self.isPlaying = false
                    }
                    
                })
                //height of video
                .frame(height: UIScreen.main.bounds.height / 3.5)
                .onTapGesture {
                    
                    self.showingControls = true
                }
                
                ScrollView(.vertical, showsIndicators: true) {
                    if apiVideos != nil {
                        VStack(spacing: 2) {
                            HStack {
                                Text(apiVideos![vidIndex].title)
                                    .bold()
                                    .font(.title)
                                    .padding(.horizontal)
                                    .padding(.top)
                                Spacer()
                                Rectangle().frame(width: 0, height: 0)
                            }
                            HStack {
                                Text(apiVideos![vidIndex].author.name)
                                    .bold()
                                    .font(.subheadline)
                                    .padding(.horizontal)
                                    .foregroundColor(.gray)
                                Spacer()
                                Rectangle().frame(width: 0, height: 0)
                            }
                            .padding(.bottom)
                            
                            Parma(apiVideos![vidIndex].videoDescription)
                                .padding(.horizontal)
                            
                            
                        }
                        
                        
                    }
                }
            }
            .onTapGesture {
                showingControls = false
            }
            .background(Color.init("systemBackground").edgesIgnoringSafeArea(.all))
            .onAppear {
                
                self.player.play()
                self.isPlaying = true
                
                
                videoCaller.getVideos { result in
                    switch result {
                    case.success(let videos):
                        
                        apiVideos = videos.sorted(by: { $0.publishedAt < $1.publishedAt})
                        
                        guard let urlString = apiVideos?[vidIndex].hlsURL else { return }
                        guard let url = URL(string: urlString) else { return }
                        
                        DispatchQueue.main.async {
                            
                            
                            let url = url
                            self.player.replaceCurrentItem(with: AVPlayerItem(url: url))
                            self.player.pause()
                            self.isPlaying = false
                            //                                markdown = videos[vidIndex].videoDescription
                            
                        }
                        print("VIDEO URL: ", urlString)
                        
                        
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            }
            .navigationTitle("Video Player")
            .navigationBarHidden(false)
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

