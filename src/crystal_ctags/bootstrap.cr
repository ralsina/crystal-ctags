require "../crystal_ctags"

filenames = ARGV
filenames.select! do |fname|
  !fname.starts_with?("-")
end

ctags = CrystalCtags::Ctags.new(filenames)
puts ctags
