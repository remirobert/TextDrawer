Pod::Spec.new do |s|
  s.name         = "TextDrawer"
  s.version      = "1.0"
  s.summary      = "TextDrawer, is a UIView allows you to add text, with gesture, on UIView, or UIImage."

  s.description  = <<-DESC
                   TextDrawer, is a UIView allows you to add text, with gesture, on UIView, or UIImage.
                   DESC

  s.homepage     = "https://github.com/remirobert/TextDrawer"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"

  s.social_media_url = 'https://twitter.com/remi936'
  s.author             = { "rémi " => "remirobert33530@gmail.com" }

  s.source       = { :git => "https://github.com/remirobert/TextDrawer.git", :tag => "1.0" }
  s.source_files = 'TextDrawer/*.swift'
  s.dependency 'Masonry'

end
