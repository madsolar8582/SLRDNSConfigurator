Pod::Spec.new do |s|
  s.name                      = 'SLRDNSConfigurator'
  s.version                   = '1.0.0'
  s.summary                   = 'Secure DNS for macOS, iOS, and tvOS.'
  s.description               = 'Helps apps implement secure DNS either via DNS over HTTPS or DNS over TLS.'
  s.homepage                  = 'https://github.com/madsolar8582/SLRDNSConfigurator'
  s.license                   = { :type => 'LGPLv3', :file => 'LICENSE.md' }
  s.author                    = 'Madison Solarana'
  s.ios.deployment_target     = '14.0'
  s.macos.deployment_target   = '11.0'
  s.tvos.deployment_target    = '14.0'
  s.watchos.deployment_target = '7.0'
  s.ios.frameworks            = 'Network', 'Foundation'
  s.macos.frameworks          = 'Network', 'Foundation'
  s.tvos.frameworks           = 'Network', 'Foundation'
  s.watchos.frameworks        = 'Network', 'Foundation'  
  s.source                    = { git: 'https://github.com/madsolar8582/SLRDNSConfigurator.git', tag: s.version.to_s }
  s.source_files              = 'SLRDNSConfigurator/**/*.{h,m}'
  s.requires_arc              = true
end
