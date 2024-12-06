# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'ai_logo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ai_logo
  pod 'IQKeyboardManagerSwift', '8.0.0'
  pod 'SJFluidSegmentedControl', '~> 1.0'
  pod 'lottie-ios'
  pod 'KVSpinnerView'
  pod 'SDWebImage', '~> 5.0'
  pod 'ProgressHUD'



end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
