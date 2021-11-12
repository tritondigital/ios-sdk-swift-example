//
//  ContentView.swift
//  TritonSwiftSample
//
//  Created by Spacial Macbook Pro on 2021/11/08.
//

import SwiftUI
import TritonPlayerSDK

struct ContentView: View {
    @ObservedObject var player: Player
    var body: some View {
        VStack(alignment: .leading){
            HStack(){
                Text("Mount Name:").bold()
                Text(self.player.mountName)
            }
            
            HStack(){
                Text("Status:").bold()
                Text( self.player.playerStatus )
            }
            
            HStack(){
                Text("CuePoint:").bold()
                Text( self.player.cuePoint )
            }
            
        }
        
        if player.playerStatus == "Stopped" {
            Button("Play") {
                player.play()
            }.padding()
                .background(Color("tritonButtonColor"))
                .foregroundColor(Color.black)
        } else {
            Button("Stop") {
                player.stop()
            }.padding()
                .background(Color("tritonButtonColor"))
                .foregroundColor(Color.black)
        }
        
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(player: Player())
    }
}


