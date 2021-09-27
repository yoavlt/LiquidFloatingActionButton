#
# Be sure to run `pod lib lint LiquidFloatingActionButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LiquidFloatingActionButton"
  s.version          = "2.2.0"
  s.summary          = "Material Design Floating Action Button in liquid state"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                      Material Design Floating Action Button in liquid state inspired by http://www.materialup.com/posts/material-in-a-liquid-state
                       DESC

  s.homepage         = "https://github.com/yoavlt/LiquidFloatingActionButton"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Takuma Yoshida" => "yoa.jmpr.w@gmail.com", "José Enrique Sánchez" => 'jesanchez@jesanchez.es' }
  s.source           = { :git => "https://github.com/jesancheza/LiquidFloatingActionButton.git", :branch => "develop" :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  s.source_files = 'Pod/Classes/**/*'
end
