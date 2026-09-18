#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dot.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'dot_flutter'
  s.version          = '1.0.14'
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
  # 2026-09-17: 'VALID_ARCHS[sdk=iphonesimulator*] = x86_64' 제거.
  # RW 의 DOT/DOTSession.xcframework 가 ios-arm64_x86_64-simulator 슬라이스를 포함하므로
  # Apple Silicon 시뮬레이터(arm64)를 막을 이유가 없고, VALID_ARCHS 는 Xcode 12 부터 deprecated 임.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
