source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

def shared_pods
    pod 'Alamofire', '~> 3.0'
    pod 'AlamofireNetworkActivityIndicator', '~> 1.0'
    pod 'AlamofireImage', '~> 2.0'
    pod 'KeychainSwift', '~> 3.0'
end

target "Inventory" do
    shared_pods
end

target "InventoryTests" do
    shared_pods
end

target "InventoryUITests" do
    shared_pods
end