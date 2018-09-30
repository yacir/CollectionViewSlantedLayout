Pod::Spec.new do |s|
  s.name             = "CollectionViewSlantedLayout"
  s.version          = "3.1.1"
  s.summary          = "UICollectionViewLayout allowing the display of slanted content on UICollectionView"

  s.description      = <<-DESC
                           CollectionViewSlantedLayout is a subclass of UICollectionViewLayout allowing the display of slanted content on UICollectionView.
                       DESC

  s.homepage         = "https://github.com/yacir/CollectionViewSlantedLayout"
  s.license          = 'MIT'
  s.author           = { "Yassir Barchi" => "http://yassir.fr" }
  s.source           = { :git => "https://github.com/yacir/CollectionViewSlantedLayout.git", :tag => s.version.to_s }
  s.social_media_url = 'http://yassir.fr'

  s.platform     = :ios, '8.0'

  s.source_files = 'Sources/**/*.{h,swift}'
  s.frameworks = 'UIKit'

  s.ios.deployment_target = '8.0'
end
