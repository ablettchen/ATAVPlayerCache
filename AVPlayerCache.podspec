#
# Be sure to run `pod lib lint AVPlayerCache.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ATAVPlayerCache'
  s.version          = '0.1.0'
  s.summary          = 'AVPlayer Cache.'
  s.homepage         = 'https://github.com/ablettchen/AVPlayerCache'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ablett' => 'ablettchen@gmail.com' }
  s.source           = { :git => 'https://github.com/ablettchen/AVPlayerCache.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ablettchen'

  s.ios.deployment_target = '8.0'
  s.swift_versions = '5.0'
  
  s.source_files = 'AVPlayerCache/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AVPlayerCache' => ['AVPlayerCache/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit' 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
