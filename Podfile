# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '11.0'
use_frameworks!

project 'MLKitExample.xcodeproj'

pod 'GoogleMLKit/BarcodeScanning', '4.0.0'
pod 'GoogleMLKit/FaceDetection', '4.0.0'
pod 'GoogleMLKit/ImageLabeling', '4.0.0'
pod 'GoogleMLKit/ImageLabelingCustom', '4.0.0'
pod 'GoogleMLKit/ObjectDetection', '4.0.0'
pod 'GoogleMLKit/ObjectDetectionCustom', '4.0.0'
pod 'GoogleMLKit/PoseDetection', '4.0.0'
pod 'GoogleMLKit/PoseDetectionAccurate', '4.0.0'
pod 'GoogleMLKit/SegmentationSelfie', '4.0.0'
pod 'GoogleMLKit/TextRecognition', '4.0.0'
pod 'GoogleMLKit/TextRecognitionChinese', '4.0.0'
pod 'GoogleMLKit/TextRecognitionDevanagari', '4.0.0'
pod 'GoogleMLKit/TextRecognitionJapanese', '4.0.0'
pod 'GoogleMLKit/TextRecognitionKorean', '4.0.0'

target 'MLKitExample' do
end


## Disable signing for pods
#post_install do |installer|
#  installer.generated_projects.each do |project|
#    project.targets.each do |target|
#        target.build_configurations.each do |config|
#            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
#         end
#    end
#  end
#end
#
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.1'
        xcconfig_path = config.base_configuration_reference.real_path
        xcconfig = File.read(xcconfig_path)
        xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
        File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
      end
    end
  end
end
