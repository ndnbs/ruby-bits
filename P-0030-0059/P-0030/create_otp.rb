!# ruby

#####
# Good example of using the OptionParser class.
# https://docs.ruby-lang.org/en/2.1.0/OptionParser.html
# http://stackoverflow.com/questions/26434923/parse-command-line-arguments-in-a-ruby-script
#####
require 'optparse'
require 'ostruct'

options = OpenStruct.new
OptionParser.new do |opt|
  opt.on('-o', '--output_file OUTPUT_FILE', 'The output file name') { |o| options.output_file = o }
  opt.on('-s', '--size SIZE', 'The size of output file in bytes') { |o| options.size = o }
end.parse!

puts "Output File:[" + options.output_file + "]"
puts "Output Size:[" + options.size + "]"

size_of_output_file = options.size.to_i

#####
# Experimenting. Keep file size small.
#####
if size_of_output_file >= 1000
  puts "Size too big."
  exit
end

#####
# Don't overwrite existing file. 
#####
if File.exists?(options.output_file)
  puts "Output file already exists. Won't overwrite."
  exit
else
  random_string = Random.new.bytes(size_of_output_file)
  File.open(options.output_file, 'w') { |file| file.write(random_string) }
end


