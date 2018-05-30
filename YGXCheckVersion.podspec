Pod::Spec.new do |s|
  s.name         = "YGXCheckVersion"
  s.version      = "1.0.1"
  s.summary      = "检查更新"
  s.description  = <<-DESC
	检查应用是否有更新，不需要上传任何参数    
             DESC
  s.homepage     = "https://github.com/lxlxl3691"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "伊广旭" => "yiguangxu@kws-info.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/lxlxl3691/YGXCheckVersion.git", :tag => "v1.0.1" }
  s.source_files  = "YGXCheckVersion/*.swift"
  s.exclude_files = "Classes/Exclude"
  s.swift_version = "3.3"
  s.dependency "Alamofire"
end

  # s.public_header_files = "Classes/**/*.h"
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  # s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }





