# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{southeastern-daily-performance}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Roos"]
  s.date = %q{2010-10-13}
  s.default_executable = %q{sedpr-to-csv}
  s.email = %q{chris@seagul.co.uk}
  s.executables = ["sedpr-to-csv"]
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md", "Rakefile", "bin", "test", "lib/southeastern_daily_performance", "lib/southeastern_daily_performance/affected_service.rb", "lib/southeastern_daily_performance/affected_services_report.rb", "lib/southeastern_daily_performance/daily_performance_report.rb", "lib/southeastern_daily_performance.rb", "bin/sedpr-to-csv"]
  s.homepage = %q{http://github.com/chrisroos/southeastern-daily-performance}
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{southeastern-daily-performance}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Converts Southeaster Daily Performance reports from HTML to CSV}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0"])
    else
      s.add_dependency(%q<hpricot>, [">= 0"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0"])
  end
end
