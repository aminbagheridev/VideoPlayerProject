//
//  LoopingPlayer.swift
//  PocketRehab
//
//  Created by Amin  Bagheri  on 2022-08-12.
//

import SwiftUI
import AVFoundation

struct LoopingPlayer: UIViewRepresentable {
    
    // When initializing this struct, we'll have to pass in the video url.
    let videoUrl: URL
    
    func makeUIView(context: Context) -> some UIView {
        return UIPlayerView(url: videoUrl)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //Do Nothing
    }
}

// This view is built with UIKit to allow for custom functionality.
class UIPlayerView: UIView {
    
    // this is a "view"", the player will go over it
    private var playerLayer = AVPlayerLayer()
    
    //make sure that url is required to be put in
    required init(url: URL) {
        
        // we do this manually,
        super.init(frame: CGRect.zero)
        // Can't call super.init() here because it's a convenience initializer not a desginated initializer
        
        // load video
        let fileUrl = url
        let playerItem = AVPlayerItem(url: fileUrl) // the video
        
        //setup player
        let player = AVPlayer(playerItem: playerItem) //this is the interface, and we are passing in a video item
        playerLayer.player = player
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.addSublayer(playerLayer)
        player.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
