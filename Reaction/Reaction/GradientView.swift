

import UIKit

@IBDesignable class GradientView: UIView {
    
    @IBInspectable var firstColor: UIColor = UIColor.whiteColor()
    @IBInspectable var secondColor: UIColor = UIColor.blackColor()
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0)
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)
   
    
    override func prepareForInterfaceBuilder() {
        
       
        
    }
    
    override func drawRect(rect: CGRect) {
        
        let gl = CAGradientLayer()
        gl.frame = layer.bounds
        gl.colors = [firstColor.CGColor, secondColor.CGColor]
        gl.locations = [0.0, 1.0]
        gl.startPoint = startPoint
        gl.endPoint = endPoint
        layer.insertSublayer(gl, atIndex: 0)
    }

  

}
