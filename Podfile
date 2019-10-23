#Podfile
use_frameworks!

platform :ios, '10.0'

## I use this to share pods between more targets whenever I need it
def sharedPods
	pod 'Alamofire', '~> 5.0.0-rc.2'
end

target 'Stella McCartney' do
    sharedPods
end

target 'Stella McCartneyTests' do
    sharedPods
end
