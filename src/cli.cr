require "option_parser"
require "./crystal_ctags"
require "./crystal_ctags/version"

ARGV << "--help" if ARGV.empty?

usage = <<-USAGE
Usage:
  crystal-ctags [OPTIONS] [FILES...]

Create a sorted CTAGS for the Crystal programming language compatible with universal-ctags.

USAGE

default_pattern = ["src/**/*.cr", "spec/**/*.cr", "lib/**/*.cr"]
reset_default_pattern = false
project_mode = false
output_path = "./CTAGS"
output_specified = false

OptionParser.parse do |parser|
  parser.banner = usage


  parser.on("-p PATTERN", "--pattern=PATTERN", "Specify the new glob pattern (may be repeated). Implies --project.
Example: --pattern='src/**/*.cr' --pattern='spec/**/*.cr'
") do |pattern|
    if reset_default_pattern == false
      reset_default_pattern = true
      default_pattern = [] of String
    end

    default_pattern << pattern

    project_mode = true
  end


  parser.on("-o tagfile", "--output=TAGFILE", "Write output to TAGFILE (default: #{output_path}).
") do |name|
    output_path = name
    output_specified = true
  end

  parser.on("--project", "Generate CTAGS for the current project (default pattern: #{default_pattern.join(", ")}),
Without --project, inputs are treated as explicit file paths and output goes to STDOUT.
") do
    project_mode = true
  end

  parser.on("-v", "--version", "Print version information and exit.") do
    puts CrystalCtags::VERSION
    exit
  end

  parser.on("-h", "--help", "Show this help message and exit.") do
    puts parser
    exit
  end

  parser.invalid_option do |flag|
    STDERR.puts "Invalid option: #{flag}.\n\n"
    STDERR.puts parser
    exit 2
  end

  parser.missing_option do |flag|
    STDERR.puts "Missing option: #{flag}\n\n"
    STDERR.puts parser
    exit 2
  end
end

def write_to_file(tag_name, pattern)
  File.write(tag_name, CrystalCtags::Ctags.new(pattern))

  STDERR.puts "OK: wrote #{tag_name} (sorted by tag name)"
end

if project_mode
  STDERR.puts "Indexing project files (patterns: #{default_pattern.join(", ")})."

  files = Dir.glob(default_pattern).uniq!

  abort "error: no files matched: #{default_pattern.join(", ")}" if files.empty?

  write_to_file(output_path, files)
else
  files = ARGV

  abort "error: no input files." if files.empty?

  if output_specified
    write_to_file(output_path, files)
  else
    puts CrystalCtags::Ctags.new(files)
  end
end
