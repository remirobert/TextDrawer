Pod::Spec.new do |s|
  s.name                  = "TextDrawer"
  s.version               = "1.0.2"
  s.summary               = "TextDrawer, is a UIView allows you to add text, with gesture, on UIView, or UIImage."
  s.requires_arc          = true
  s.homepage              = "https://github.com/remirobert/TextDrawer"
  s.ios.deployment_target = '8.0'
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license               = "MIT"

  s.social_media_url      = 'https://twitter.com/remi936'
  s.author                = { "rémi " => "remirobert33530@gmail.com" }

  s.source                = { :git => "https://github.com/remirobert/TextDrawer.git", :commit => "bd62414b6d1d32eaa8db4e9c9150124487440784", :tag => "1.0.2" }
  s.source_files = 'TextDrawer/*.swift'
  s.dependency 'Masonry'
end
