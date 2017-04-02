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
  opt.on('-i', '--input_file INPUT_FILE', 'Input file name') { |o| options.input_file = o }
  opt.on('-o', '--output_file OUTPUT_FILE', 'Output file name') { |o| options.output_file = o }
  opt.on('-x', '--input_xor_file', 'Input XOR file') { |o| options.input_xor_file = o }
end.parse!

puts "Input File     :[" + options.input_file + "]"
puts "Output File    :[" + options.output_file + "]"
puts "Input XOR File :[" + options.input_xor_file + "]"

#####
# Ensure that input file exists. 
#####
unless File.exists?(options.input_file)
  puts "Input file does not exist."
  exit
end

#####
# Ensure that input XOR file exists. 
#####
unless File.exists?(options.input_xor_file)
  puts "Input XOR file does not exist."
  exit
end

#####
# Ensure that input file and input XOR file are exactly the same size. 
#####
unless ((File.stat(options.input_file).size) == (File.stat(options.input_xor_file).size))
  puts "Input file and input XOR file must be exactly the same size."
  exit
end

#####
# Don't overwrite existing file. 
#####
if File.exists?(options.output_file)
  puts "Output file already exists. Won't overwrite."
  exit
end

#####
# Now, open our two(2) input files and one(1) output file.
#####
input_xor_fd = File.open(options.input_xor_file, 'rb')
output_fd    = File.open(options.output_file, 'wb')

File.open(options.input_file, 'rb') do |input_fd|
  until input_fd.eof?
    input_buffer     = input_fd.read(1)
    input_xor_buffer = input_xor_fd.read(1)
    # Do something with buffer
    # puts buffer
    output_fd.write(input_buffer.to_i(2) ^ input_xor_buffer.to_i(2))
  end
end

#{ |file| file.write(random_string) }
#random_string = Random.new.bytes(size_of_output_file)
#File.open(options.output_file, 'w') { |file| file.write(random_string) }


