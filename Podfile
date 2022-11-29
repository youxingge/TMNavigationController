source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'

inhibit_all_warnings!

def my_pods
    
    pod 'MLeaksFinder', :git => "https://github.com/Tencent/MLeaksFinder.git", :configurations => ['Debug']

end

target 'TMNavigationController' do
    my_pods
end

# github token
# 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



#post_install do |installer|
#  installer.project.targets.each do |target|
#    target.build_configurations.each do |config|
#      config.build_settings['ARCHS'] = "armv7"
#    end
#  end
#  end
