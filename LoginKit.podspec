Pod::Spec.new do |s|
  s.name             = 'LoginKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of LoginKit.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/danlozano/LoginKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Lozano' => 'dan@danielozano.com' }
  s.source           = { :git => 'https://github.com/danlozano/LoginKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danlozanov'

  s.ios.deployment_target = '9.0'

  s.source_files = 'LoginKit/Classes/**/*'
  s.resources = 'LoginKit/Assets/*.{xib,storyboard,xcassets}'
  # s.resource_bundles = {
  #   'LoginKit' => ['LoginKit/Assets/*.{xib,storyboard,xcassets}']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Validator', '~> 2.1.1'
  s.dependency 'FBSDKLoginKit', '4.18.0'
  #s.dependency 'SkyFloatingLabelTextField', '~> 2.0.0'

end
