require "option_parser"
require "json"
require "./crystal_ctags"
require "./crystal_ctags/version"

ARGV << "--help" if ARGV.empty?

usage = <<-USAGE
Usage:
Create a sorted CTAGS for the Crystal programming language compatible with universal-ctags.

USAGE

filenames = ARGV
default_pattern = ["src/**/*.cr", "spec/**/*.cr", "lib/**/*.cr"]
reset_default_pattern = false
project = false
tag_name = "./CTAGS"
new_tag_name = false

OptionParser.parse do |parser|
  parser.banner = usage

  parser.on("-p PATTERN", "--pattern=PATTERN", "Specify the glob pattern (can be repeated) used to create the CTAGS index.
e.g. --pattern=\"src/**/*.cr\" --pattern \"spec/**/*.cr\"
Specifying this option implicitly includes --project.") do |pattern|
    if reset_default_pattern == false
      reset_default_pattern = true
      default_pattern = [] of String
    end

    default_pattern << pattern

    project = true
  end

  parser.on("-o tagfile", "--output=TAGFILE", "TAG file name, default: #{tag_name}") do |name|
    tag_name = name
    new_tag_name = true
  end

  parser.on("--project", "Generate CTAGS for current project, default: #{default_pattern}") do
    project = true
  end

  parser.on("-h", "--help", "Show this help message and exit") do
    puts parser
    exit
  end

  parser.on("-v", "--version", "Show version") do
    puts CrystalCtags::VERSION
    exit
  end

  parser.invalid_option do |flag|
    STDERR.puts "Invalid option: #{flag}.\n\n"
    STDERR.puts parser
    exit 1
  end

  parser.missing_option do |flag|
    STDERR.puts "Missing option: #{flag}\n\n"
    STDERR.puts parser
    exit 1
  end
end

if project
  STDERR.puts "Writing #{tag_name} for current project use pattern: #{default_pattern}"

  filenames = Dir.glob(default_pattern)

  abort "Can't found file result use #{default_pattern}" if filenames.empty?

  File.write(tag_name, CrystalCtags::Ctags.new(filenames))
else
  abort "Can't found file result use #{ARGV}" if ARGV.empty?

  if new_tag_name
    File.write(tag_name, CrystalCtags::Ctags.new(ARGV))
  else
    puts CrystalCtags::Ctags.new(ARGV)
  end
end
