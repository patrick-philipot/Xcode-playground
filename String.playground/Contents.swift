import UIKit
import AVFoundation
// import MediaPlayer


// let speechSynthesizer = AVSpeechSynthesizer()
let longTextFR = """
La Cigale, ayant chanté tout l'été,
Se trouva fort dépourvue,
Quand la bise fut venue.
"""

class Speaker:NSObject {
    static let synthesizer = AVSpeechSynthesizer()
    var voiceID: String?
    
    init(voiceID: String){
        super.init()
        self.voiceID = voiceID
        if Speaker.synthesizer.delegate == nil {
            Speaker.synthesizer.delegate = self
        }
        print("init")
    }
    
    func readText(someText: String) {
        let speakUtterance = AVSpeechUtterance(string: someText)
        speakUtterance.voice = AVSpeechSynthesisVoice(identifier: self.voiceID!)
        speakUtterance.postUtteranceDelay = 1.0
        Speaker.synthesizer.speak(speakUtterance)
    }
}

extension Speaker: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("\(self.voiceID!) speechSynthesizer didFinish ")
    }
}

//guard let fileUrl = Bundle.main.url(forResource: "gladiateurs", withExtension: "mp3") else { fatalError() }
//print(fileUrl)

//let query: MPMediaQuery = MPMediaQuery.playlists()
//let playlists = query.collections
//
//for playlist in playlists!{
//    // print(playlist.value(forProperty: MPMediaPlaylistPropertyName)!)
//    print(playlist.value(forProperty: MPMediaPlaylistPropertyName)! as! String)
//}


let amelie = Speaker(voiceID: "com.apple.ttsbundle.Amelie-compact")
amelie.readText(someText: longTextFR)
