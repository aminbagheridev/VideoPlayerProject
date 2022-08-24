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
    
    var body : some View{
        
        VStack{
            Spacer()
            HStack{
                
                Button(action: {
                    
                    
                    
                    
                }) {
                    
                    Image("previous")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
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
                    Image(self.isplaying ? "pause" : "play")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }
                Spacer()
                Button(action: {
                    self.player.seek(to: CMTime(seconds: self.getSeconds() + 10, preferredTimescale: 1))
                    
                }) {
                    Image("next")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
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







