#encoding:utf-8
# Be sure to run `pod lib lint'
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html

Pod::Spec.new do |s|
  s.name = "RXKit"
  s.version = begin; File.read('version.txt'); rescue; '0.1.0'; end
  s.summary = "RXExts."

  s.description = <<-DESC
使用RxSwift提供一套完整开发工具。
DESC

  s.homepage = "https://github.com/yaochenfeng/RXKit"
  s.source           = { :git => "https://github.com/yaochenfeng/RXKit.git", :tag => 'v' + s.version.to_s }
  s.license = {
    :type => "MIT",
    :text => "MIT"
  }
  s.author = { "yaochenfeng" => "282696845@qq.com" }
  s.platform = :ios, "11.0"
  s.swift_version = "5.4"
  s.dependency "RxCocoa", "~> 6.0"
  s.dependency "SnapKit", "~> 5.0"
  s.preserve_path = 'version.txt'

  s.subspec 'DFService' do |sp|
    sp.source_files = "Sources/#{sp.name}/*.swift"
  end
  s.subspec 'Extension' do |sp|
    sp.source_files = "Sources/#{sp.name}/*.swift"
  end
  s.subspec 'View' do |sp|
    sp.source_files = "Sources/#{sp.name}/*.swift"
    sp.dependency "RXKit/Extension"
  end
  s.subspec 'ViewModel' do |sp|
    sp.source_files = "Sources/#{sp.name}/*.swift"
    sp.dependency "RXKit/Extension"
  end
  s.subspec 'Route' do |sp|
    sp.source_files = "Sources/#{sp.name}/*.swift"
    sp.dependency "RXKit/ViewModel"
  end
end
