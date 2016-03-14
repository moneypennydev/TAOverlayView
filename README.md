# TAOverlayView

<!-- [![CI Status](http://img.shields.io/travis/Nick Yap/TAOverlayView.svg?style=flat)](https://travis-ci.org/Nick Yap/TAOverlayView) -->
<!-- [![Version](https://img.shields.io/cocoapods/v/TAOverlayView.svg?style=flat)](http://cocoapods.org/pods/TAOverlayView) -->
<!-- [![License](https://img.shields.io/cocoapods/l/TAOverlayView.svg?style=flat)](http://cocoapods.org/pods/TAOverlayView) -->
<!-- [![Platform](https://img.shields.io/cocoapods/p/TAOverlayView.svg?style=flat)](http://cocoapods.org/pods/TAOverlayView) -->




## Overview

This library was created to implement engaging overlay walkthrough tutorials that highlight portions of the screen with "holes" through the overlay. The holes can be rectangular or circular, and users can tap through the holes. There can be multiple holes in a single overlay, and these holes can be added to the overlay after instantiation.

Below is a tutorial in one of our apps that employs this overlay:

![Example](http://i.imgur.com/vnITWJl.gifv "Tutorial in our affirmations app, Mind Over Matter (shameless plug)")


## Requirements
Embedded frameworks require a minimum deployment target of iOS 8.

## Installation

### CocoaPods

TAOverlayView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TAOverlayView"
```

## Objective-C Compatibility
If you used CocoaPods, you should be able to import the files using

```@import TAOverlayView;```

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Class Overview

It's worth going through a quick overview of the available classes. The main class is the `TAOverlayView` which inherits from `UIView` and allows you to easily create a semi-transparent overlay above a specified frame.

The `TAOverlayView` can have "holes" subtracted from it, allowing users to see and interact with items behind the overlay. In order to create these holes, we use either a `TARectangularSubtractionPath` (for rectangular holes) or a `TACircularSubtractionPath` (for circular holes). Both of these inherit from the `TABaseSubtractionPath` and allow for the easy construction of a `UIBezierPath`.


## Creating a Walkthrough Tutorial
This library was created for implementing walkthrough tutorials, so let's go through an example of how to do just that.

Note: the Example project shows a full implementation of the following example, so we recommend checking that out as well.


### Instantiating Overlay

Let's say that you have two buttons, `button1` and `button2`. You want to have a full-screen overlay with a rectangular hole over `button1`. Tapping `button1` will reveal `button2` through a circular hole. In your `UIViewController`, add the following:

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    var overlayView: TAOverlayView?

    override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)

      // Note: the overlay was created in ``viewDidAppear`` so that the button frame is
      // already set. Instantiating in ``viewDidLoad``, etc., might place
      // the hole in the wrong location.


      // Create the initial overlay over the entire
      // screen, with a rectangular hole over ``button1``.

      let overlay = TAOverlayView(frame: CGRectMake(0, 0,
         UIScreen.mainScreen().bounds.width,
         UIScreen.mainScreen().bounds.height), subtractedPaths: [
      TARectangularSubtractionPath(frame: self.button1.frame,
      horizontalPadding: 10.0, verticalPadding: 5.0)
      ])

      // Add as subview.
      self.view.addSubview(overlay)

      // Set a reference to the overlay (to hide, add more holes, etc.).
      self.overlayView = overlay
    }


Note that the `subtractedPaths` argument of the `TAOverlayView` init function takes an array of `TABaseSubtractionPath`'s so you can instantiate the overlay with multiple holes (or no holes), if necessary.

### Adding Holes After Instantiation

Sometimes you might want to add more holes to the overlay after instantiation. In our example, we want to highlight `button2` after the user taps `button1`. Hook up an IBAction outlet to the "Touch Up Inside" action of the button. In that IBAction, Simply use ``subtractFromView`` on the overlay to add another hole to the existing overlay:


    @IBAction func createNewHole(sender: AnyObject) {
      // Add a circular hole above ``button2``.
      // There will now be two holes in the overlay.
      self.overlayView?.subtractFromView([
        TACircularSubtractionPath(frame: self.button2.frame, radius: 40.0)
        ])
    }

This creates a circular hole above `button2`. As with the init function of the overlay, `subtractFromView` takes an array of `TABaseSubtractionPath`'s so you add multiple holes simultaneously.

## Dismissing the Overlay

In order to dismiss the overlay, we can fade it out and remove it from the superview with the following:

    if let overlayView = self.overlayView {
      UIView.animateWithDuration(1.0, animations: {
        // Fade out the overlay.
        overlayView.alpha = 0.0
        }, completion: {(completed: Bool) -> Void in
          // Remove the overlay and its reference.
          overlayView.removeFromSuperview()
          self.overlayView = nil
        })
    }

## Creating Custom Holes

In order to create holes other than rectangles or circles, you can subclass `TABaseSubtractionPath` to create custom shapes. Simply override the private `createPath` function and return your custom `UIBezierPath`. View the implementations of `TARectangularSubtractionPath` or `TACircularSubtractionPath` to see this in action.


## Author

Nick Yap, nick@toboggan.mobi

## License

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
