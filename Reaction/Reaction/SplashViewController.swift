

import UIKit
import GameKit

class SplashViewController: UIViewController, GKGameCenterControllerDelegate {

    @IBOutlet weak var topScoreLabel: UILabel!
    @IBOutlet weak var leaderboard: UIButton!
    
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
    
    
    @IBAction func showLeaderboard(sender: UIButton) {
        
        let gameVC = GKGameCenterViewController()
        gameVC.leaderboardIdentifier = "reaction_touched"
        gameVC.gameCenterDelegate = self
        presentViewController(gameVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }


}

