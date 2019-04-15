Pod::Spec.new do |s|
  s.name         = "Tagging"
  s.version      = "0.5.0"
  s.summary      = "TextView that provides a tagging feature to Mention or Hashtag"
  s.homepage     = "https://github.com/k-lpmg/Tagging"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "DongHee Kang" => "kanglpmg@gmail.com" }
  s.source       = { :git => "https://github.com/k-lpmg/Tagging.git", :tag => s.version.to_s }
  s.documentation_url = "https://github.com/k-lpmg/Tagging/blob/master/README.md"

  s.ios.source_files  = "Sources/**/*.swift"
  s.ios.deployment_target = "8.0"
end
