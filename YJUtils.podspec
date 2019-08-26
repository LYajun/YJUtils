#
# Be sure to run `pod lib lint YJUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YJUtils'
  s.version          = '1.0.3'
  s.summary          = '工具类'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LYajun/YJUtils'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LYajun' => 'liuyajun1999@icloud.com' }
  s.source           = { :git => 'https://github.com/LYajun/YJUtils.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  
  s.subspec 'YJAudioPlayer' do |audioPlayer|
      audioPlayer.source_files = 'YJUtils/Classes/YJAudioPlayer/**/*'
  end

  s.subspec 'YJAudioMerger' do |audioMerger|
      audioMerger.source_files = 'YJUtils/Classes/YJAudioMerger/**/*'
  end
end
