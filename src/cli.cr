require "option_parser"
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
project_mode = false
tag_name = "./CTAGS"
specify_new_tag_name = false

OptionParser.parse do |parser|
  parser.banner = usage

  parser.on("-p PATTERN", "--pattern=PATTERN", "Specify the glob pattern (can be repeated) used to create the CTAGS index.
e.g. --pattern=\"src/**/*.cr\" --pattern \"spec/**/*.cr\"
Specifying this option implicitly includes --project.
") do |pattern|
    if reset_default_pattern == false
      reset_default_pattern = true
      default_pattern = [] of String
    end

    default_pattern << pattern

    project_mode = true
  end

  parser.on("-o tagfile", "--output=TAGFILE", "TAG file name if create CTAGS for project, default: #{tag_name}
") do |name|
    tag_name = name
    specify_new_tag_name = true
  end

  parser.on("--project", "Generate CTAGS for project, default pattern: #{default_pattern},
Without this option, will output CTAGS to STDOUT.
") do
    project_mode = true
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

def write_to_file(tag_name, pattern)
  File.write(tag_name, CrystalCtags::Ctags.new(pattern))

  STDERR.puts "OK: wrote #{tag_name} (sorted by tag name)"
end

if project_mode
  STDERR.puts "Writing #{tag_name} for current project use pattern: #{default_pattern}"

  filenames = Dir.glob(default_pattern)

  abort "Can't found file result use #{default_pattern}" if filenames.empty?

  write_to_file(tag_name, filenames)
else
  abort "Can't found file result use #{ARGV}" if ARGV.empty?

  if specify_new_tag_name
    write_to_file(tag_name, ARGV)
  else
    puts CrystalCtags::Ctags.new(ARGV)
  end
end
