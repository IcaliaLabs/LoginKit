Pod::Spec.new do |s|
  s.name             = 'ILLoginKit'
  s.version          = '1.0.0'
  s.summary          = 'LoginKit is a quick and easy way to add a Login/Signup UX to your app.'
  s.description      = <<-DESC
LoginKit handles Signup & Login, via Facebook & Email. It takes care of the UI, the forms, validation, and Facebook SDK access.
All you need to do is start LoginKit, and then make the necessary calls to your own backend API to login or signup.
                       DESC
  s.homepage         = 'https://github.com/icalialabs/LoginKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Lozano' => 'dan@danielozano.com' }
  s.source           = { :git => 'https://github.com/icalialabs/LoginKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danlozanov'

  s.ios.deployment_target = '9.0'

  s.source_files = 'LoginKit/Classes/**/*'
  s.resources = 'LoginKit/Assets/*.{xib,xcassets,png,jpg,otf,ttf}'
  # s.resource_bundles = {
  #   'LoginKit' => ['LoginKit/Assets/*.{xib,storyboard,xcassets}']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Validator', '~> 2.1.1'
  s.dependency 'FBSDKLoginKit', '4.31.0'

end
