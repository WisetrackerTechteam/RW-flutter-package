#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dot.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'dot_flutter'
  s.version          = '1.0.9'
  s.summary          = 'Wisetracker RW SDK flutter plugin'
  s.description      = <<-DESC
Wisetracker RW SDK flutter plugin.
                       DESC
  s.homepage         = 'http://www.wisetracker.co.kr'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'wisetracker' => 'tech@wisetracker.co.kr' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.ios.dependency 'RW'

  s.platform = :ios, '12.0'
  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
