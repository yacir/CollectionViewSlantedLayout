Pod::Spec.new do |s|
  s.name             = "YBSlantedCollectionViewLayout"
  s.version          = "2.2.0"
  s.summary          = "UICollectionViewLayout allowing the display of slanted content on UICollectionView"

  s.description      = <<-DESC
                           YBSlantedCollectionViewLayout is a subclass of UICollectionViewLayout allowing the display of slanted content on UICollectionView.
                       DESC

  s.homepage         = "https://github.com/yacir/YBSlantedCollectionViewLayout"
  s.license          = 'MIT'
  s.author           = { "Yassir Barchi" => "dev.yassir@gmail.com" }
  s.source           = { :git => "https://github.com/yacir/YBSlantedCollectionViewLayout.git", :tag => s.version.to_s }
  s.social_media_url = 'https://linkedin.com/in/yassir-barchi-318a7949'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/*.{h,swift}'
  s.frameworks = 'UIKit'

  s.ios.deployment_target = '8.0'
end
