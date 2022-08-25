//
//  Controls.swift
//  VideoPlayerSwiftUI
//
//  Created by Amin  Bagheri  on 2022-08-24.
//

import Foundation
import SwiftUI
import AVKit

struct Controls : View {
    
    @Binding var player: AVPlayer
    @Binding var isplaying: Bool
    @Binding var pannel: Bool
    @Binding var value: Float
    @Binding var vidIndex: Int
    @Binding var videos: Video?
    
    var body : some View{
        
        VStack{
            Spacer()
            HStack {
                
                if vidIndex == 0 {
                    Button(action: {
                        if !(vidIndex == 0) {
                            vidIndex -= 1
                        }
                    }) {
                        
                        ZStack {
                            Circle()
                                .frame(width: 61, height: 61)
                                .foregroundColor(.black)
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white.opacity(0.9))
                            Image("previous")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(20)
                        }
                        
                        
                        
                    }
                    .opacity(0.3)
                    .disabled(true)
                    
                } else {
                    Button(action: {
                        if !(vidIndex == 0) {
                            vidIndex -= 1
                        }
                    }) {
                        
                        ZStack {
                            Circle()
                                .frame(width: 61, height: 61)
                                .foregroundColor(.black)
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white.opacity(0.9))
                            Image("previous")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(20)
                        }
                        
                        
                        
                    }
                }
                
                Spacer()
                
                Button(action: {
                    
                    if self.isplaying{
                        
                        self.player.pause()
                        self.isplaying = false
                    }
                    else{
                        self.player.play()
                        self.isplaying = true
                    }
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 67, height: 67)
                            .foregroundColor(.black)
                        Circle()
                            .frame(width: 66, height: 66)
                            .foregroundColor(.white.opacity(0.9))
                    Image(self.isplaying ? "pause" : "play")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                    }
                }
                Spacer()
                
                if videos != nil {
                    let lastVideo = videos?.last
                    let lastIndex = videos!.firstIndex(where: { $0.id == lastVideo?.id })
                    if (vidIndex == lastIndex) {
                        Button(action: {
                            if videos != nil {
                                let lastVideo = videos?.last
                                let lastIndex = videos!.firstIndex(where: { $0.id == lastVideo?.id })
                                if !(vidIndex == lastIndex) {
                                    vidIndex += 1
                                }
                            }
                            
                            
                        }) {
                            ZStack {
                                Circle()
                                    .frame(width: 61, height: 61)
                                    .foregroundColor(.black)
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white.opacity(0.9))
                                Image("next")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(20)
                            }
                        }.opacity(0.3)
                            .disabled(true)
                    } else {
                        Button(action: {
                            if videos != nil {
                                let lastVideo = videos?.last
                                let lastIndex = videos!.firstIndex(where: { $0.id == lastVideo?.id })
                                if !(vidIndex == lastIndex) {
                                    vidIndex += 1
                                }
                            }
                            
                            
                        }) {
                            ZStack {
                                Circle()
                                    .frame(width: 61, height: 61)
                                    .foregroundColor(.black)
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white.opacity(0.9))
                                Image("next")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(20)
                            }
                        }
                    }
                }
                
            }
            Spacer()
            CustomProgressBar(value: self.$value, player: self.$player, isplaying: self.$isplaying)
            
        }.padding()
            .background(Color.black.opacity(0.4))
            .onTapGesture {
                self.pannel = false
            }
            .onAppear {
                self.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { (_) in
                    self.value = self.getSliderValue()
                    if self.value == 1.0{
                        self.isplaying = false
                    }
                }
            }
    }
    
    func getSliderValue() -> Float{
        
        return Float(self.player.currentTime().seconds / (self.player.currentItem?.duration.seconds)!)
    }
    
    func getSeconds() -> Double{
        
        return Double(Double(self.value) * (self.player.currentItem?.duration.seconds)!)
    }
}







