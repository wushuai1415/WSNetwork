#
# Be sure to run `pod lib lint WSNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WSNetwork'
  s.version          = '0.1.0'
  s.summary          = 'A short description of WSNetwork.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wushuai1415/WSNetwork'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ws' => 'ws1350@hotmail.com' }
  s.source           = { :git => 'https://github.com/wushuai1415/WSNetwork.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WSNetwork/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WSNetwork' => ['WSNetwork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 2.3'

  s.subspec 'Categories' do |ss|
    ss.source_files = 'WSNetwork/Classes/Categories/**/*'
  end
  s.subspec 'Components' do |ss|
      ss.source_files = 'WSNetwork/Classes/Components/**/*'
  end
  s.subspec 'Generators' do |ss|
      ss.source_files = 'WSNetwork/Classes/Generators/**/*'
  end
  s.subspec 'Manager' do |ss|
      ss.source_files = 'WSNetwork/Classes/Manager/**/*'
  end
  s.subspec 'Services' do |ss|
      ss.source_files = 'WSNetwork/Classes/Services/**/*'
  end
end
