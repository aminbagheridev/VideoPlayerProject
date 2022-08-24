//
//  CustomProgressBar.swift
//  VideoPlayerSwiftUI
//
//  Created by Amin  Bagheri  on 2022-08-24.
//

import Foundation
import SwiftUI
import UIKit
import AVKit

struct CustomProgressBar : UIViewRepresentable {
    
    
    func makeCoordinator() -> CustomProgressBar.Coordinator {
        
        return CustomProgressBar.Coordinator(parent1: self)
    }
    
    
    @Binding var value : Float
    @Binding var player : AVPlayer
    @Binding var isplaying : Bool
    
    func makeUIView(context: UIViewRepresentableContext<CustomProgressBar>) -> UISlider {
        
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.thumbTintColor = .red
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.value = value
        slider.addTarget(context.coordinator, action: #selector(context.coordinator.changed(slider:)), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: UIViewRepresentableContext<CustomProgressBar>) {
        
        uiView.value = value
    }
    
    class Coordinator : NSObject{
        
        var parent : CustomProgressBar
        
        init(parent1 : CustomProgressBar) {
            
            parent = parent1
        }
        
        @objc func changed(slider : UISlider){
            
            if slider.isTracking{
                
                parent.player.pause()
                
                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))
                
                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
            }
            else{
                
                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))
                
                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
                
                if parent.isplaying{
                    
                    parent.player.play()
                }
            }
        }
    }
}
