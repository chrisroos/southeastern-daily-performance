desc <<-EndDesc
*NOTE* You'll probably want to run this before pushing the site.
I need to iterate over directory content to build the archive pages. I don't think this is possible in plain jekyll/liquid so I created a script to pre-generate the templates.
EndDesc
task :build_archive_pages do
  ruby File.expand_path("../_additional/generate-archives.rb", __FILE__)
end