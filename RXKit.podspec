#encoding:utf-8
# Be sure to run `pod lib lint'
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html

Pod::Spec.new do |s|
  s.name = "RXKit"
  s.version = "0.1.0"
  s.summary = "RXExts."

  s.description = <<-DESC
使用RxSwift提供一套完整开发工具。
DESC

  s.homepage = "https://github.com/yaochenfeng/#{s.name}"
  s.source           = { :git => "https://github.com/yaochenfeng/#{s.name}.git", :branch => "master" }
  s.license = {
    :type => "MIT",
    :text => <<-LICENSE,
copyright MIT
LICENSE
  }
  s.author = { "yaochenfeng" => "chenfengyao@foxmail.com" }
  s.platform = :ios, "11.0"
  s.swift_version = "5.4"
  s.source_files = "Sources/#{s.name}/**/*.swift"
  s.dependency "RxCocoa", "~> 6.0"
  s.dependency "SnapKit", "~> 5.0"
end
