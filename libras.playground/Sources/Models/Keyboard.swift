import Foundation

public class Keyboard {
    let alphabet: String = "abcdefghijklmnopqrstvuwxyz"
    var keys: [Key] = []
    var keyImages: [String] = []
    
    init(){
        let initialX: Double = 15.0
        var x: Double = initialX
        for (index, letter) in self.alphabet.enumerated(){
            if index < 7{
                self.keys.append(Key(tag: index+1, letter: letter, img: String(letter)+".png", x: x, y: 300.0))
            }
            if index == 7{
                x = initialX
            }
            if index >= 7 && index < 14 {
                self.keys.append(Key(tag: index+1, letter: letter, img: String(letter)+".png", x: x, y: 350.0))
            }
            if index == 14{
                x = initialX
            }
            if index >= 14 && index < 21 {
                self.keys.append(Key(tag: index+1, letter: letter, img: String(letter)+".png", x: x, y: 400.0))
            }
            if index == 21{
                x = 65
            }
            if index >= 21 {
                self.keys.append(Key(tag: index+1, letter: letter, img: String(letter)+".png", x: x, y: 450.0))
            }
            x = x + 50
        }
    }
}
