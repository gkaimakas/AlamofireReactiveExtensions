#
# Be sure to run `pod lib lint AlamofireReactiveExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'AlamofireReactiveExtensions'
    s.version          = '2.0.0'
    s.summary          = 'Extensions that mix ReactiveSwift with Alamofire'

    s.description      = <<-DESC
            Want to use ReactiveSwift with Alamofire? AlamofireReactiveExtensions has you covered. It provides a list of extensions that bridge Alamofire's callbacks with ReactiveSwift's SignalProducers. You can even easily apply ReactiveSwift's operators to your responses, combine multiple requests or execute requests consecutively.'
                       DESC

    s.homepage         = 'https://github.com/gkaimakas/AlamofireReactiveExtensions'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'gkaimakas' => 'gkaimakas@gmail.com' }
    s.source           = { :git => 'https://github.com/gkaimakas/AlamofireReactiveExtensions.git', :tag => s.version.to_s }

    s.ios.deployment_target = '9.0'

    s.source_files = 'AlamofireReactiveExtensions/Classes/**/*'

    s.dependency 'Alamofire', '~> 4.0'
    s.dependency 'ReactiveSwift',  '~> 2.0'
end
