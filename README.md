# TAOverlayView

[![CI Status](http://img.shields.io/travis/Nick Yap/TAOverlayView.svg?style=flat)](https://travis-ci.org/Nick Yap/TAOverlayView)
[![Version](https://img.shields.io/cocoapods/v/TAOverlayView.svg?style=flat)](http://cocoapods.org/pods/TAOverlayView)
[![License](https://img.shields.io/cocoapods/l/TAOverlayView.svg?style=flat)](http://cocoapods.org/pods/TAOverlayView)
[![Platform](https://img.shields.io/cocoapods/p/TAOverlayView.svg?style=flat)](http://cocoapods.org/pods/TAOverlayView)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

insert gif

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


## Creating a walkthrough tutorial.

### Instantiating Overlay


### Adding Holes After Instantiation

Sometimes you might want to add more holes to the overlay after instantiation. For example, in a walkthrough tutorial, you might want to highlight another portion of the screen after the user taps a button (see the example project for a full implementation). Simply use ``subtractFromView`` on the overlay to add another hole to the existing overlay:



    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    var overlayView: TAOverlayView?

    override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)

      // Note: this was created in ``viewDidAppear`` so that the button frame is
      // already set. Instantiating in ``viewDidLoad``, etc., might place
      // the hole in the wrong location.


      // Create the initial overlay over the entire
      // screen, with a rectangular hole over the ``button1``.

      let overlay = TAOverlayView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width,
      UIScreen.mainScreen().bounds.height), subtractedPaths: [
      TARectangularSubtractionPath(frame: self.button1.frame,
      horizontalPadding: 10.0, verticalPadding: 5.0)
      ])

      // Add as subview.
      self.view.addSubview(overlay)

      // Set a reference to the overlay (to hide, add more holes, etc.).
      self.overlayView = overlay
    }

    @IBAction func createNewHole(sender: AnyObject) {
      // Add a circular hole above ``button2``.
      // There will now be two holes in the overlay.
      self.overlayView?.subtractFromView([
        TACircularSubtractionPath(frame: self.button2.frame, radius: 40.0)
        ])
    }

### Creating Multiple Holes


## Author

Nick Yap, nick@toboggan.mobi

## License

TAOverlayView is available under the MIT license. See the LICENSE file for more info.
