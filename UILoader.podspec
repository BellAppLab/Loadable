Pod::Spec.new do |s|
  s.name             = "UILoader"
  s.version          = "0.6.1"
  s.summary          = "A small Swift library that adds convenience methods to UIKit classes so they handle loading remote data more easily."
  s.homepage         = "https://github.com/BellAppLab/UILoader"
  s.license          = 'MIT'
  s.author           = { "Bell App Lab" => "apps@bellapplab.com" }
  s.source           = { :git => "https://github.com/BellAppLab/UILoader.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/BellAppLab'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*.{swift}'
  s.frameworks = 'UIKit'
end
