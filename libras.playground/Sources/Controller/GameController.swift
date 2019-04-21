import UIKit //: Only for apps, games is another kit
import PlaygroundSupport // Show liveview

let words = Word()
var section: [String: String] = [:]

public class CategoriesController: UIViewController {
    let backBtn = UIButton(frame: CGRect(x: 15, y: 15, width: 25, height:25))
    
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
        let title = UILabel()
        title.frame = CGRect(x: 40, y: 70, width: 300, height: 50)
        title.text = "Choose a category:"
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 32)
        view.addSubview(title)
        
        let natureImage = UIImage(named: "teste.png")
        var natureBtn = UIButton(frame: CGRect(x: 10, y: 180, width: 110, height: 110))
        natureBtn.setImage(natureImage, for: .normal)
        natureBtn.setTitle("Nature", for: .normal)
        natureBtn.tag = MenuTags.nature.rawValue
        natureBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let booksImage = UIImage(named: "books.png")
        var booksBtn = UIButton(frame: CGRect(x: 130, y: 180, width: 110, height: 110))
        booksBtn.setImage(booksImage, for: .normal)
        booksBtn.setTitle("Objects", for: .normal)
        booksBtn.tag = MenuTags.objects.rawValue
        booksBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let bodyImage = UIImage(named: "body.png")
        var bodyBtn = UIButton(frame: CGRect(x: 250, y: 180, width: 110, height: 110))
        bodyBtn.setImage(bodyImage, for: .normal)
        bodyBtn.setTitle("Body", for: .normal)
        bodyBtn.tag = MenuTags.body.rawValue
        bodyBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let foodImage = UIImage(named: "cheeseburger.png")
        var foodBtn = UIButton(frame: CGRect(x: 250, y: 300, width: 110, height: 110))
        foodBtn.setImage(foodImage, for: .normal)
        foodBtn.setTitle("Food", for: .normal)
        foodBtn.tag = MenuTags.food.rawValue
        foodBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let personImage = UIImage(named: "emoji.png")
        var personBtn = UIButton(frame: CGRect(x: 130, y: 300, width: 110, height: 110))
        personBtn.setImage(personImage, for: .normal)
        personBtn.setTitle("Person", for: .normal)
        personBtn.tag = MenuTags.person.rawValue
        personBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let mixImage = UIImage(named: "mixed.png")
        var mixBtn = UIButton(frame: CGRect(x: 10, y: 300, width: 110, height: 110))
        mixBtn.setImage(mixImage, for: .normal)
        mixBtn.setTitle("Mix", for: .normal)
        mixBtn.tag = MenuTags.person.rawValue
        mixBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.backBtn.tag = -1
        self.backBtn.setTitle("<", for: .normal)
        self.backBtn.setTitleColor(.white, for: .normal)
        self.backBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        self.backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        view.addSubview(self.backBtn)
        
        let btnList = [natureBtn, bodyBtn, foodBtn, mixBtn, booksBtn, personBtn]
        
        styleBtn(btn: &natureBtn)
        styleBtn(btn: &bodyBtn)
        styleBtn(btn: &foodBtn)
        styleBtn(btn: &mixBtn)
        styleBtn(btn: &booksBtn)
        styleBtn(btn: &personBtn)
        btnList.forEach{ btn in
            view.addSubview(btn)
        }
        self.view = view
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let btnSendTag: UIButton = sender
        
        switch btnSendTag.tag {
        case MenuTags.nature.rawValue:
            section = words.nature
        case MenuTags.food.rawValue:
            section = words.food
        case MenuTags.body.rawValue:
            section = words.body
        case MenuTags.mix.rawValue:
            section = words.mixed
        case MenuTags.objects.rawValue:
            section = words.object
        case MenuTags.person.rawValue:
            section = words.clothing
        default:
            print("Invalid tag.")
        }
        PlaygroundPage.current.liveView = GameController()
    }
    
    private func styleBtn(btn: inout UIButton){
        btn.imageEdgeInsets = UIEdgeInsets(top: 15.0, left: 30.0, bottom: 40.0, right: 30.0)
        btn.backgroundColor = .white
        btn.titleEdgeInsets = UIEdgeInsets(top: 80.0, left: -70.0, bottom: 0.0, right: 0.0)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 80.0, left: -70.0, bottom: 0.0, right: 0.0)
        btn.backgroundColor = .white
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.layer.cornerRadius = 5.0
        btn.layer.shadowOffset = CGSize(width: 5, height: 5)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 5.0
        btn.layer.shadowOpacity = 0.5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    @objc func backAction(sender: UIButton!) {
        PlaygroundPage.current.liveView = InitialController()
    }
    
}

public class GameController: UIViewController {
    var hint: Int = 0 // Number of hints
    var element: (key: String, value: String) = ("", "")
    // Word from the section
    var wholeWord: Array<Character> = Array() // Array of characters of section word
    var imgWord: String = ""
    var auxWord: Array<Character> = Array()
    var numberOfLetters: Int = 0
    var hit: Bool = true
    let alphabetArr = Array("abcdefghijklmnopqrstvuwxyz".uppercased())
    
    let wordContainer = UILabel(frame: CGRect(x: 10, y: 200, width: 360, height: 50))
    let keyboardContainer = UIView(frame: CGRect(x: 0, y: 290, width: 450, height: 450))
    let backBtn = UIButton(frame: CGRect(x: 15, y: 15, width: 25, height:25))
    var imageContainer = UILabel()
    var hintBtn = UIButton(frame: CGRect(x: 275, y: 12, width: 90, height: 30))
    
    let keyboard = Keyboard()
    var keyboardBtns: [UIButton] = []
    
    var checkImage = UILabel(frame: CGRect(x: 205, y: 130, width: 50, height: 50))
    
    private func initKeyboard(){
        var auxBtn: UIButton
        for key in self.keyboard.keys{
            auxBtn = UIButton(frame: CGRect(x: key.x, y: key.y, width: 45, height: 45))
            if let image = UIImage(named: key.img){
                auxBtn.setImage(image, for: .normal)
            }
            auxBtn.backgroundColor = .white
            auxBtn.tag = key.tag
            auxBtn.imageEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
            auxBtn.layer.cornerRadius = 4.0
            auxBtn.addTarget(self, action: #selector(keyAction), for: .touchUpInside)
            self.keyboardBtns.append(auxBtn)
            
        }
    }
    
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
        self.imageContainer.frame = CGRect(x: 125, y: 50, width: 130, height: 130)
        self.imageContainer.font = imageContainer.font.withSize(64.0)
        self.imageContainer.textAlignment = .center
        self.imageContainer.backgroundColor = .white
        
        self.hintBtn.backgroundColor = UIColor(red: 59.0/255, green: 219.0/255, blue: 96.0/255, alpha: 1.0)
        self.hintBtn.layer.cornerRadius = 5.0
        self.hintBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.hintBtn.setTitleColor(.white, for: .normal)
        self.hintBtn.addTarget(self, action: #selector(hintAction), for: .touchUpInside)
        
        self.wordContainer.textColor = .white
        self.wordContainer.textAlignment = .center
        self.wordContainer.font = wordContainer.font.withSize(50)
        
        self.checkImage.textAlignment = .center
        self.checkImage.font = checkImage.font.withSize(32)
        
        self.keyboardContainer.backgroundColor = UIColor.lightGray
        
        self.backBtn.tag = -1
        self.backBtn.setTitle("<", for: .normal)
        self.backBtn.setTitleColor(.white, for: .normal)
        self.backBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        self.backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        newWord()
        
        view.addSubview(hintBtn)
        view.addSubview(self.wordContainer)
        view.addSubview(imageContainer)
        view.addSubview(self.keyboardContainer)
        view.addSubview(self.backBtn)
        view.addSubview(checkImage)
        initKeyboard()
        for key in self.keyboardBtns{
            view.addSubview(key)
        }
        self.view = view
        
    }
    
    @objc func hintAction(sender: UIButton!) {
        if self.hint > 0 {
            self.hint = self.hint - 1
            if self.hint == 0{
                sender.backgroundColor = .red
            }
            
            sender.setTitle("HINT: \(self.hint)", for: .normal)
            
            let hintLetter: Character = self.element.key.uppercased().randomElement()!
            
            while self.wholeWord.contains(hintLetter) {
                if let index = self.wholeWord.firstIndex(of: hintLetter){
                    self.wholeWord[index] = "1"
                    self.auxWord[index] = hintLetter
                    self.imgWord = ""
                    for i in 0..<auxWord.count{
                        self.imgWord = self.imgWord + String(self.auxWord[i])+" "
                    }
                    self.wordContainer.text = self.imgWord
                    //                    self.view.addSubview(self.wordContainer)
                    self.numberOfLetters = self.numberOfLetters - 1
                    
                    if self.numberOfLetters == 0 {
                        self.hit = true
                        newWord()
                    }
                }
            }
        }
    }
    
    @objc func backAction(sender: UIButton!) {
        PlaygroundPage.current.liveView = CategoriesController()
    }
    
    @objc func keyAction(sender: UIButton!) {
        let letter: Character = self.alphabetArr[sender.tag-1]
        
        if self.element.key.uppercased().contains(letter){
            sender.backgroundColor = .green
        }
        else {
            sender.backgroundColor = .red
        }
        
        while self.wholeWord.contains(letter) {
            if let index = self.wholeWord.firstIndex(of: letter){
                self.wholeWord[index] = "1"
                self.auxWord[index] = letter
                self.imgWord = ""
                
                for i in 0..<auxWord.count{
                    self.imgWord = self.imgWord + String(self.auxWord[i])+" "
                }
                self.wordContainer.text = self.imgWord

                self.numberOfLetters = self.numberOfLetters - 1
                
                if self.numberOfLetters == 0 {
                    self.hit = true
                    self.checkImage.text = "✅"
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.newWord()
                        self.checkImage.text = ""
                    })
                    
                }
            }
        }
    }
    
    private func newWord() {
        if self.hit {
            if !section.isEmpty{
                
                self.auxWord = []
                self.imgWord = ""
                self.element = section.randomElement()!
                self.wholeWord = Array(self.element.key.uppercased())
                
                self.hint = self.element.key.count/3
                self.hintBtn.backgroundColor = UIColor(red: 59.0/255, green: 219.0/255, blue: 96.0/255, alpha: 1.0)
                self.numberOfLetters = self.element.key.count
                self.hintBtn.setTitle("HINT: \(self.hint)", for: .normal)
                
                self.imageContainer.text = self.element.value
                
                for _ in 0..<self.element.key.count{
                    self.auxWord.append(Character("_"))
                    self.imgWord = self.imgWord + String("_ ")
                }
                self.wordContainer.text = self.imgWord
                
                for btnKey in self.keyboardBtns {
                    btnKey.backgroundColor = .white
                }
                
                section[element.key] = nil
                self.hit = false
            }
            else {
                PlaygroundPage.current.liveView = EndController()
            }
        }
    }
}
