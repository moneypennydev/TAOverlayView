Pod::Spec.new do |s|
  s.name             = "TAOverlayView"
  s.version          = "1.0.0"
  s.summary          = "Creates semi-transparent overlay views with holes to see behind the overlay. Useful for walkthrough tutorials."


  s.description      = <<-DESC
This library was created to implement engaging overlay walkthrough tutorials that highlight portions of the screen with "holes" through the overlay. The holes can be rectangular or circular, and users can tap through the holes. There can be multiple holes in a single overlay, and these holes can be added to the overlay after instantiation.

                       DESC

  s.homepage         = "https://github.com/TobogganApps/TAOverlayView"
  s.license          = 'Apache 2.0'
  s.author           = { "Nick Yap" => "nick@toboggan.mobi" }
  s.source           = { :git => "https://github.com/TobogganApps/TAOverlayView.git", :tag => s.version.to_s }


  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'TAOverlayView' => ['Pod/Assets/*.png']
  }

end
