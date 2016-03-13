/*
Copyright © 2016 Toboggan Apps LLC. All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import UIKit
import TAOverlayView

class SecondViewController: UIViewController {
    
    @IBOutlet var tapMeButton: UIButton!
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var label: UILabel!
    
    
    var overlayView: TAOverlayView?
    
    /// Determines if we have already added the circular hole.
    var addedCircularHole = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Set the label as white so we can see it above the overlay.
        self.label.textColor = UIColor.whiteColor()
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Created in ``viewDidAppear`` so that the button frame is already set. Instantiating in ``viewDidLoad``, etc., might place the hole in the wrong location.
        
        if self.overlayView == nil {
            // Create the semi-transparent overlay over the entire screen, with a rectangular hole over the ``tapMeButton``.
            let overlay = TAOverlayView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width,
                UIScreen.mainScreen().bounds.height), subtractedPaths: [
                    TARectangularSubtractionPath(frame: self.tapMeButton.frame,
                        horizontalPadding: 10.0, verticalPadding: 5.0)
                ])
            
            
            // Add as subviews.
            self.view.addSubview(overlay)
            overlay.addSubview(self.label) // So we can see the label above the overlay.
            
            // Set a reference to the overlay (to hide, add more holes, etc.).
            self.overlayView = overlay
        }
        
        
    }
    
    @IBAction func createCircularHole(sender: AnyObject) {
        if !self.addedCircularHole {
            self.addedCircularHole = true
            
            // Add a circular hole above the ``backButton``. There will now be two holes in the overlay.
            self.overlayView?.subtractFromView([TACircularSubtractionPath(frame: self.backButton.frame, radius: 40.0)])
        }
        
    }
    
    @IBAction func goBack(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
}
