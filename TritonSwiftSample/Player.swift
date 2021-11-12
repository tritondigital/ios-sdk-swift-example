//
//  Player.swift
//  TritonSwiftSample
//
//  Created by Spacial Macbook Pro on 2021/11/08.
//

import Foundation
import UIKit
import TritonPlayerSDK

class Player : NSObject, TritonPlayerDelegate, ObservableObject {
    @Published var playerStatus: String = "Stopped"
    @Published var mountName: String = "TRITONRADIOMUSICAAC"
    @Published var cuePoint: String = ""
    
    var tritonPlayer:TritonPlayer?
    var playerSettings: [AnyHashable: Any]?
    

    override init(){
        super.init()
        playerSettings = [SettingsStationNameKey:"TRITONRADIOMUSIC",
                               SettingsMountKey : self.mountName,
                       SettingsBroadcasterKey : "Triton Digital"]
        
        self.tritonPlayer = TritonPlayer(delegate: self, andSettings: playerSettings)
    }
    
    func play(){
        self.cuePoint = ""
        self.tritonPlayer?.play();
    }
    
    func stop(){
        self.cuePoint = ""
        self.tritonPlayer?.stop();
    }
    
    func player(_ player: TritonPlayer!, didChange state: TDPlayerState) {
        switch state {
            case .stopped:
            self.playerStatus = "Stopped"
                break
            case .playing:
            self.playerStatus = "Playing"
                break
            case .connecting:
                self.playerStatus = "Connecting"
                break
            case .error:
            self.playerStatus = "Error"
                break
            default:
                break
        }
    }
    
    func player(_ player: TritonPlayer!, didReceive cuePointEvent: CuePointEvent){
        let jsonData = try? JSONSerialization.data(withJSONObject: cuePointEvent.data!, options: [])
        self.cuePoint = String(data: jsonData!, encoding: String.Encoding.ascii)!
    }
    
    func playerBeginInterruption(_ player: TritonPlayer!) {
        print("Playback was interrupted")
        if(self.tritonPlayer?.isExecuting)!{
            self.tritonPlayer?.stop()
        }
    }
    
    func playerEndInterruption(_ player: TritonPlayer!) {
        print("Player interruption ended");
        let shouldResume = self.tritonPlayer?.shouldResumePlaybackAfterInterruption;
        if(shouldResume!){
            print("Playback should resume now");
            self.tritonPlayer?.play();
        } else{
            print("Playback is not going to resume");
        }
    }
    
}
