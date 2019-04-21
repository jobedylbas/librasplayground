import Foundation
import UIKit
import PlaygroundSupport

public class EndController: UIViewController {
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
        let container = UILabel(frame: CGRect(x: 10, y: 10, width: 360, height: 490))
        container.layer.cornerRadius = 4.0
        container.layer.masksToBounds = true
        container.backgroundColor = .white
        view.addSubview(container)
        
        let title = UILabel(frame: CGRect(x: 10, y: 40, width: 355, height: 50))
        title.text = "CONGRATULATIONS !!"
        title.textColor = UIColor.purple
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(title)
        
        let trophy = UILabel(frame: CGRect(x: 10, y: 100, width: 355, height: 120))
        trophy.text = "🏆"
        trophy.textAlignment = .center
        trophy.font = trophy.font.withSize(120)
        view.addSubview(trophy)
        
        let title2 = UILabel(frame: CGRect(x: 10, y: 260, width: 355, height: 50))
        title2.text = "You complete this category 😃"
        title2.textAlignment = .center
        title2.font = UIFont.boldSystemFont(ofSize: 18)
        title2.textColor = .purple
        view.addSubview(title2)
        
        let title3 = UILabel(frame: CGRect(x: 10, y: 300, width: 355, height: 50))
        title3.text = "To learn more, try another category"
        title3.textAlignment = .center
        title3.font = UIFont.boldSystemFont(ofSize: 18)
        title3.textColor = .purple
        view.addSubview(title3)
        
        let menuBtn = UIButton(frame: CGRect(x: 135, y: 400, width: 120, height: 50))
        menuBtn.setTitle("Menu", for: .normal)
        menuBtn.backgroundColor = UIColor.purple
        menuBtn.layer.cornerRadius = 4.0
        menuBtn.setTitleColor(.white, for: .normal)
        menuBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        menuBtn.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
        view.addSubview(menuBtn)
        
        self.view = view
        
    }
    
    @objc func menuAction(sender: UIButton!) {
        PlaygroundPage.current.liveView = InitialController()
    }
}

