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
default_pattern = ["src/**/*.cr", "lib/**/*.cr"]
project = false
tag_name = "./CTAGS"

OptionParser.parse do |parser|
  parser.banner = usage

  parser.on("-h", "--help", "Show this help message and exit") do
    puts parser
    exit
  end

  parser.on("-v", "--version", "Show version") do
    puts CrystalCtags::VERSION
    exit
  end

  parser.on("-p PATTERN", "--pattern=PATTERN", "Specify the file pattern used to create the CTAGS index.
e.g. --pattern='[\"src/**/*.cr\", \"spec/**/*.cr\"]'

Specifying this option implicitly includes --project.
") do |pattern|
    default_pattern = pattern
    project = true
  end

  parser.on("--project", "Generate CTAGS for current project, default pattern: #{default_pattern}") do
    project = true
  end

  parser.on("-o tagfile", "--output=TAGFILE", "TAG file name, , default: #{tag_name}") do |name|
    tag_name = name
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

  pattern = default_pattern.is_a?(String) ? Array(String).from_json(default_pattern.as(String)) : default_pattern
  filenames = Dir.glob(pattern)

  File.write(tag_name, CrystalCtags::Ctags.new(filenames)) unless filenames.empty?
else
  puts CrystalCtags::Ctags.new(ARGV)
end
