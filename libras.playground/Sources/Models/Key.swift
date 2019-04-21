import Foundation

struct Key {
    var tag: Int
    var letter: Character
    var x: Double = 5.0
    var y: Double = 300.0
    var img: String = ""
    
    init(tag: Int, letter: Character, img: String, x: Double, y: Double) {
        self.tag = tag
        self.letter = letter
        self.img = img
        self.x = x
        self.y = y
    }
}
