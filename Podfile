# Uncomment this line to define a global platform for your project
platform :ios, "8.0"

target 'sample' do
pod 'Realm', '~> 0.95'
end

post_install do | installer |
    require 'fileutils'
    FileUtils.cp_r('Pods/Target Support Files/Pods-sample/Pods-sample-acknowledgements.plist', 'sample/Settings.bundle/Acknowledgements.plist', :remove_destination => true)
end

