
Pod::Spec.new do |s|
  s.name             = 'UISkeleton'
  s.version          = '0.1.1'
  s.summary          = 'A simple way to show users a placeholder for the real content that the app is about to show them'

  s.description      = <<-DESC
Speed Up Your UX with Skeleton Screens. A simple way to show users a placeholder for the real content that the app is about to show them
                       DESC

  s.homepage         = 'https://github.com/dmanuelcl/UISkeleton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dani Manuel Céspedes Lara' => 'dmanuelcl@gmail.com' }
  s.source           = { :git => 'https://github.com/dmanuelcl/UISkeleton.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'UISkeleton/Classes/**/*'

  s.dependency 'Skeleton', '0.1.0'
end
