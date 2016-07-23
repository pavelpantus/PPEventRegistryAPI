Pod::Spec.new do |s|
  s.name             = 'PPEventRegistryAPI'
  s.version          = '0.0.1'
  s.summary          = 'Swift framework for accessing data in Event Registry (http://eventregistry.org/)'

  s.description      = <<-DESC
PPEventRegistryAPI is a Swift framework for accessing Event Registry data (http://eventregistry.org/)

                       DESC

  s.homepage         = 'https://github.com/pantuspavel/PPEventRegistryAPI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pavel Pantus' => 'pantusp@gmail.com' }
  s.source           = { :git => 'https://github.com/pantuspavel/PPEventRegistryAPI.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/pantusp'

  s.ios.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'
  s.tvos.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'

  s.requires_arc  = true

  s.frameworks = 'Foundation'

  s.source_files = 'PPEventRegistryAPI/Classes/**/*.{swift}'
end
