

import UIKit
import GameKit

class SplashViewController: UIViewController {

    @IBOutlet weak var topScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GKLocalPlayer.localPlayer().authenticateHandler = { (viewController, error) -> Void in
            
            if viewController != nil {
                self.presentViewController(viewController, animated: true, completion: nil)
            } else {
                println(GKLocalPlayer.localPlayer().authenticated)
                
                self.loadScore()
            }

        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        loadScore()
    }
    
    func loadScore() {
        
        if GKLocalPlayer.localPlayer().authenticated == false { return }
        
        GKLeaderboard.loadLeaderboardsWithCompletionHandler { (leaderboards, error) -> Void in
            
            for leaderboard in leaderboards as! [GKLeaderboard] {
                if leaderboard.identifier == "reaction_touched" {
                    
                    leaderboard.loadScoresWithCompletionHandler({ (scores, error) -> Void in
                        
                        self.topScoreLabel.text = "\(leaderboard.localPlayerScore.value)"
                    })
                }
            }
        }
        
    }
    
    
    @IBAction func go(sender: UIButton) {
        
        if  let gameVC = storyboard?.instantiateViewControllerWithIdentifier("GameVC") as? GameViewController {
            
            navigationController?.viewControllers = [gameVC]
        }
    }


}

