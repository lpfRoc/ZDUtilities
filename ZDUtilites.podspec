Pod::Spec.new do |s|

s.name = 'ZDUtilites'
s.version = '1.0.2'
s.license = 'MIT'
s.summary = 'Tool module'
s.homepage = 'https://github.com/lpfRoc/ZDUtilities'
s.author = { 'lpf' => 'https://lpfroc.github.io' }
s.source = { :git => 'https://github.com/lpfRoc/ZDUtilities.git', :tag => s.version }

s.ios.deployment_target = '7.0'

s.source_files = 'ZDUtilities/*.{h,m}'
end

