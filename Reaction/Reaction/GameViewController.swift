

import UIKit
import GameKit

class GameViewController: UIViewController {
    
    
    var currentScore = 0 {
        
        didSet {scoreLabel.text = "\(currentScore)"}
        
    }
    
    let scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
    
    var timeBar = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
    
    var currentCircles: [CircleButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeBar.backgroundColor = UIColor.blackColor()
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 80)
        scoreLabel.text = "0"
        scoreLabel.frame.origin.y = view.frame.height - 120
        scoreLabel.frame.size.width = view.frame.width
        scoreLabel.textAlignment = NSTextAlignment.Center
        animateNewCirclesIn()
        view.addSubview(timeBar)
        view.addSubview(scoreLabel)
    }
    
    func runTimer(seconds: NSTimeInterval) {
        
        timeBar.layer.removeAllAnimations()
        
        timeBar.frame.size.width = view.frame.width
        
        UIView.animateWithDuration(seconds, animations: { () -> Void in
            
            self.timeBar.frame.size.width = 0
            
            }) { (finished) -> Void in
                
                if finished { self.gameOver() }
        }
    }
    
    var currentCorrectButton: Int = Int(arc4random_uniform(4))
    
    func tapButton(button: CircleButton) {
        
        // Check if it is the correct button
        
        if button.choice == currentCorrectButton {
            
            currentScore++
            
            let reportScore = GKScore(leaderboardIdentifier: "reaction_touched")
            reportScore.value = Int64(currentScore)
            
            GKScore.reportScores([reportScore], withCompletionHandler: { (error) -> Void in
                
                println("reported")
            })
            
            currentCorrectButton = Int(arc4random_uniform(4))
            
            animateOldCirclesOut()
            currentCircles = []
            animateNewCirclesIn()
        } else {
            gameOver()
        }
    }
    
    func animateNewCirclesIn() {
        
        runTimer(1.0)
        
        let circleWidth = (view.frame.width - 120) / 2
        let circleRadius = circleWidth / 2
        
        // top left, top right, bottom left, bottom right
        // (x,y)
        let directions: [(CGFloat,CGFloat)] = [(-1,-1),(1,-1),(-1,1),(1,1)]
        
        
        for c in 0..<4 {
            
            let circle = CircleButton()
            circle.choice = c
            circle.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            circle.center = view.center
            view.addSubview(circle)
            
            circle.alpha = c == currentCorrectButton ? 1.0 : 0.5
            
            circle.addTarget(self, action: "tapButton:", forControlEvents: .TouchUpInside)
            
            currentCircles.append(circle)
            
            let(dx,dy) = directions[c]
            
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                
                circle.alpha = 0.5
                
                circle.frame.size.width = circleWidth
                circle.frame.size.height = circleWidth
                
                let x = self.view.center.x + dx * (circleRadius + 10)
                let y = self.view.center.y + dy * (circleRadius + 10)
                
                circle.center = CGPoint(x: x, y: y)
                
                }, completion: nil)
            
            
        }
    }
    
    func animateOldCirclesOut() {
        
        let cW = (view.frame.width - 120) / 2 * 3
        
        for circle in currentCircles {
            
            circle.choice = 4 // so you cant double tap and cheat
            
            let distX = circle.center.x - view.center.x
            let distY = circle.center.y - view.center.y
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
                circle.frame.size.width = cW
                circle.frame.size.height = cW
                
                circle.center = CGPoint(x: distX * 6 + self.view.center.x, y: distY * 6 + self.view.center.y) // circle.view.center for hyperdrive animation
                
                }, completion: { (finished) -> Void in
                    
                    circle.removeFromSuperview()
            })
        }
        
    }
    
    
    func endGame() {
        
        if let splashVC = storyboard?.instantiateViewControllerWithIdentifier("splashVC") as? SplashViewController {
            
            navigationController?.viewControllers = [splashVC]
        }
        
    }
    
    func gameOver() {
        
        animateOldCirclesOut()
        
        let gameOverLabel = UILabel(frame: view.frame)
        
        gameOverLabel.textAlignment = .Center
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 60)
        
        gameOverLabel.alpha = 0
        
        view.addSubview(gameOverLabel)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            gameOverLabel.alpha = 1
            self.scoreLabel.alpha = 0
            
            }) { (finished) -> Void in
                
                UIView.animateWithDuration(2.0, animations: { () -> Void in
                    
                    gameOverLabel.alpha = 0
                    
                }, completion: { (finished) -> Void in
                    
                    self.endGame()
                })
                
                
                
                self.gameOver()
        }
    }

    
}
