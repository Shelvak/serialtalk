Gem::Specification.new do |s|
  s.name = 'serialtalk'
  s.version = '0.0.1'
  s.executables << 'serialtalk'
  s.summary = 'SerialTalk'
  s.description = 'Serial communication to print in fiscal printers'
  s.authors = ['Nestor Coppi']
  s.email = 'nestorcoppi@gmail.com.com'
  s.files = ['lib/serialtalk.rb']
  s.homepage = 'http://rubygems.org/gems/serialtalk'
  s.add_dependency(['serialport', 'trollop'])
end
