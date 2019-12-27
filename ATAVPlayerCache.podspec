#
# Be sure to run `pod lib lint ATAVPlayerCache.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ATAVPlayerCache'
  s.version          = '0.1.2'
  s.summary          = 'AVPlayer Cache.'
  s.homepage         = 'https://github.com/ablettchen/ATAVPlayerCache'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ablett' => 'ablettchen@gmail.com' }
  s.source           = { :git => 'https://github.com/ablettchen/ATAVPlayerCache.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ablettchen'

  s.ios.deployment_target = '8.0'
  s.swift_versions = '5.0'

  s.source_files = 'ATAVPlayerCache/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ATAVPlayerCache' => ['ATAVPlayerCache/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
