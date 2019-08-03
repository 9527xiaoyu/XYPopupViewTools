#
# Be sure to run `pod lib lint XYPopupViewTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name         = 'XYPopupViewTools'
  s.version      = '0.1.3'
  s.summary      = 'XYPopupViewTools是一个将弹出式视图简易化集成工具，一句话完成弹出式视图部署'

  s.homepage     = 'https://github.com/9527xiaoyu/XYPopupViewTools'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { '9527xiaoyu' => '1446899815@qq.com' }
  # s.social_media_url   = 'https://github.com/9527xiaoyu'
  s.source       = { :git => 'https://github.com/9527xiaoyu/XYPopupViewTools.git', :tag => s.version.to_s}
  
  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
  core.source_files  = 'XYPopupViewTools', 'XYPopupViewTools/**/*.{h,m}'
  core.public_header_files = 'XYPopupViewTools/**/*.h'
  end
end