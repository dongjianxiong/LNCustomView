#
# Be sure to run `pod lib lint LNImageCicleScrollView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LNImageCicleScrollView'
  s.version          = '1.1.0'
  s.summary          = 'a simple component to surport images circle scroll.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
             a simple component to surport images circle scroll, I hope it will help you.
                       DESC

  s.homepage         = 'https://github.com/dongjianxiong/'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lenny' => 'jianxiong20090919@126.com' }
  s.source           = { :git => 'https://github.com/dongjianxiong/LNCustomView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LNImageCicleScrollView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LNImageCicleScrollView' => ['LNImageCicleScrollView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
