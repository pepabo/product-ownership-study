require 'pathname'
require 'date'
require 'fileutils'
require 'front_matter_parser'

dest_base = Pathname.new(`ghq list -p tech.pepabo.com`.chomp)

loader = FrontMatterParser::Loader::Yaml.new(whitelist_classes: [Date])

Pathname.glob('./source/_posts/*.md').each do |f|
  fm = FrontMatterParser::Parser.parse_file(f, loader: loader).front_matter
  dest = dest_base.join('source', 'blog', fm['date'].year.to_s, '%02d' % fm['date'].month, '%02d' % fm['date'].day, f.basename('.md'))
  FileUtils.mkdir_p(dest)
  FileUtils.cp(f, dest.join('index.html.md'))
end
