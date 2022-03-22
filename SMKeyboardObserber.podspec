#
# Be sure to run `pod lib lint SMKeyboardObserber.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SMKeyboardObserber'
  s.version          = '1.0.0'
  s.summary          = 'Keyboard observer for UIKit app.'
  s.description      = 'Keyboard observer for UIKit app.'
  s.homepage         = 'https://github.com/bobandiga/SMKeyboardObserber'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bobandiga' => 'shmx.dev@gmail.com' }
  s.source           = { :git => 'https://github.com/bobandiga/SMKeyboardObserber.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'

  s.source_files = 'SMKeyboardObserber/Sources/**/*'
  # s.resource_bundles = {
  #   'SMKeyboardObserber' => ['SMKeyboardObserber/Assets/*.png']
  # }
  s.frameworks = 'UIKit'

  # TEST SPEC
  s.test_spec 'Tests' do |ts|
    ts.requires_app_host = true
    # ts.app_host_name = 'SMEMBUnitTests/AppHost'

    ts.source_files = "#{s.name}/Tests/**/*.swift"

    # ts.resources = "#{s.name}/Tests/Resources/Stubs/**/*.{json,png}"

    # Dependecies
    # ts.dependecy 'Some', ~> 'x.y.z'
  end
end
