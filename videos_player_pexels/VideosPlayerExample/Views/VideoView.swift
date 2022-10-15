//
//  VideoView.swift
//  VideosPlayerExample
//
//  Created by Mirza Baig on 28/09/22.
//

import SwiftUI
import AVKit

struct VideoView: View {
    var videos: Video
    @State private var player = AVPlayer()
    
    var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                if let link = videos.videoFiles.first?.link {
                    player = AVPlayer(url: URL(string: link)!)
                    player.play()
                }
            }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(videos: previewVideo)
    }
}
