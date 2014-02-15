Pod::Spec.new do |s|
  s.name             = "CGLMail"
  s.version          = "0.1.0"
  s.summary          = "Classes for email."
  s.license          = 'MIT'
  s.author           = { "Chris Ladd" => "c.g.ladd@gmail.com" }
  s.source           = { :git => "git@github.com:chrisladd/CGLMail.git", :tag => s.version.to_s }
  
  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Classes/*.{h,m}'
  
  s.frameworks = 'MessageUI'
end
