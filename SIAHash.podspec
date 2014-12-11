#
# Be sure to run `pod lib lint SIAHash.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SIAHash"
  s.version          = "0.1.0"
  s.summary          = "SIAHash is hash utility"
  s.description      = <<-DESC
                       SIAHash is hash utility.
                       Can create md5/sha1/sha224/sha256/sha384/sha512 hash.
                       DESC
  s.homepage         = "https://github.com/siagency/SIAHash"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "SI Agency" => "support@si-agency.co.jp" }
  s.source           = { :git => "https://github.com/siagency/SIAHash.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'SIAHash' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'Security'
  # s.dependency 'AFNetworking', '~> 2.3'
end
