Pod::Spec.new do |s|

s.name = 'ZDUtilities'
s.version = '1.0.4'
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.summary = 'Tool module'
s.homepage = 'https://github.com/lpfRoc/ZDUtilities'
s.author = { 'lpf' => 'https://lpfroc.github.io' }
s.source = { :git => 'https://github.com/lpfRoc/ZDUtilities.git', :tag => s.version }

s.ios.deployment_target = '8.0'

s.source_files = 'ZDUtilities/*.{h,m}'
s.frameworks = 'Foundation'

end
