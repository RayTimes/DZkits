Pod::Spec.new do |spec|
  spec.name         = "DZkits"
  spec.version      = "0.0.1"
  spec.summary      = "类别常用整理"
  spec.description  = <<-DESC
  常用category
                   DESC
                   
  spec.homepage     = "https://github.com/RayTimes/DZkits"
  

   spec.license = { :type => 'MIT', :text => <<-LICENSE
          Copyright DZ 2020-2021
           LICENSE
       }

  spec.author             = { "zhaold" => "loveinsideyou@163.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "8.0"


  spec.source       = { :git => "https://github.com/RayTimes/DZkits.git", :tag => "#{spec.version}" }


  spec.source_files  = "DZkits/DZtool/**/*.{h,m}"
 
  spec.public_header_files = "DZkits/DZTool/*.h"

  spec.requires_arc = true

end
