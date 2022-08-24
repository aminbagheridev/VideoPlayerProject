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
    
    @State var vidIndex: Int = 0
    @State var apiVideos: Video?
    let videoCaller = VideoCaller.shared
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "loading", withExtension: "mp4")!)
    @State var isplaying = false
    @State var showcontrols = false
    @State var value : Float = 0
    
    var body: some View {
        NavigationView {
            VStack{
                
                ZStack{
                    
                    VideoPlayer(player: $player)
                    
                    if self.showcontrols{
                        
                        Controls(player: self.$player, isplaying: self.$isplaying, pannel: self.$showcontrols,value: self.$value, vidIndex: $vidIndex, videos: self.$apiVideos)
                    }
                    
                }
                .onChange(of: vidIndex, perform: { newValue in
                    if apiVideos != nil {
                        self.player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: apiVideos![vidIndex].hlsURL)! ) )
                        self.player.pause()
                        self.isplaying = false
                    }
                    
                })
                .frame(height: UIScreen.main.bounds.height / 3.5)
                .onTapGesture {
                    
                    self.showcontrols = true
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
                showcontrols = false
            }
            .background(Color.init("systemBackground").edgesIgnoringSafeArea(.all))
            .onAppear {
                
                self.player.play()
                self.isplaying = true
                
                
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
                            self.isplaying = false
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

