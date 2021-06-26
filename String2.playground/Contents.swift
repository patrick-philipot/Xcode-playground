import UIKit
import AVFoundation

// let speechSynthesizer = AVSpeechSynthesizer()
let longTextFR = """
C'est un trou de verdure où chante une rivière,
Accrochant follement aux herbes des haillons
D'argent ; où le soleil, de la montagne fière,
Luit : c'est un petit val qui mousse de rayons.
"""

let longtextEN = """
Success is not final, failure is not fatal: it is the courage to continue that counts.
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

let amelie = Speaker(voiceID: "com.apple.ttsbundle.Amelie-compact")
amelie.readText(someText: longTextFR)
amelie.readText(someText: "Tout petit texte")

let karen = Speaker(voiceID: "com.apple.ttsbundle.Karen-compact")
karen.readText(someText: longtextEN)


//var voices : [AnyObject] = []
//voices = AVSpeechSynthesisVoice.speechVoices()
//
//for voice in voices where voice.language!.starts(with: "en"){
//    print(voice.language + " " + voice.name + " " + voice.identifier )
//}
//
//func ios_readText(leTexte : String, voiceID : String) {
//    let speakUtterance = AVSpeechUtterance(string: leTexte)
//    speakUtterance.voice = AVSpeechSynthesisVoice(identifier: voiceID)
//    speakUtterance.postUtteranceDelay = 1.0
//
//    speechSynthesizer.speak(speakUtterance)
//}
//
//let myText1 = "Il fait très beau aujourd'hui?"
//
//let myText2 = "Oh oui. Le soleil brille !"
//ios_readText(leTexte: myText1, voiceID: "com.apple.ttsbundle.Amelie-compact")
//ios_readText(leTexte: myText2, voiceID: "com.apple.ttsbundle.Amelie-compact")
//



