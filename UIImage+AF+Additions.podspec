Pod::Spec.new do |s|
  s.name     = 'UIImage+AF+Additions'
  s.version  = '2.0'
  s.platform = :ios
  s.license  = 'MIT'
  s.summary  = 'Convenience additions for UIImage'
  s.homepage = 'https://github.com/melvitax/UIImageAFAdditions'
  s.author   = { 'Melvin Rivera' => 'melvin@allforces.com' }
  s.source   = { :git => 'https://github.com/melvitax/UIImageAFAdditions.git', :tag => s.version.to_s }
  s.description = 'A simple UIImage convenience category for handling blur effects, corner radius and creation from color or UIVIews.'
  s.source_files = 'UIImage+AF+Additions/*'
  s.framework    = 'QuartzCore'
  s.requires_arc = true
end
