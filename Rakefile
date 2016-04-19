require 'erb'

task :clean do
  mkdir_p "target"
  rm_rf "target/*"
end

desc "Builds filters & dashboards"
task :build => :clean do
  puts "===> Building ..."
  compile_erb 'src/logstash-filters/spring.conf.erb', 'target/logstash-filters-spring.conf'

  puts "===> Artifacts:"
  puts `find target`
end

desc "Runs unit tests against filters & dashboards"
task :test, [:rspec_files] => :build do |t, args|
  args.with_defaults(:rspec_files => "$(find test -name '*spec.rb')")
  puts "===> Testing ..."
  sh %Q[ LANGUAGE="C.UTF-8" LC_ALL="C.UTF-8" LANG="C.UTF-8" vendor/logstash/bin/rspec #{args[:rspec_files]} --colour --format progress --format html --out target/parsing_rules.html]
end

def compile_erb(source_file, dest_file)
  if File.extname(source_file) == '.erb'
    output = ERB.new(File.read(source_file)).result(binding)
    File.write(dest_file, output)
  else
    cp source_file, dest_file
  end
end
