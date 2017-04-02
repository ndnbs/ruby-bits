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
  opt.on('-i', '--input_file FILENAME', 'Input file name')    { |o| options.input_file = o }
  opt.on('-o', '--output_file FILENAME', 'Output file name')  { |o| options.output_file = o }
  opt.on('-x', '--xor_input_file FILENAME', 'XOR input file') { |o| options.xor_input_file = o }
end.parse!

ifn = options.input_file.to_s
ofn = options.output_file.to_s
xfn = options.xor_input_file.to_s

puts "==========================================================================================="
puts "Input File     :[" + ifn + "]"
puts "XOR Input File :[" + xfn + "]"
puts "Output File    :[" + ofn + "]"
puts "==========================================================================================="

#####
# Ensure that input file exists. 
#####
unless File.exists?(ifn)
  puts "Input file: [" + ifn + "] does not exist."
  exit
end

#####
# Ensure that XOR input file exists. 
#####
unless File.exists?(xfn)
  puts "XOR input file: [" + xfn + "] does not exist."
  exit
end

#####
# Ensure that input file and input XOR file are exactly the same size. 
#####
unless ((File.stat(ifn).size) == (File.stat(xfn).size))
  puts "Input file: [" + ifn + "] and input XOR file: [" + xfn + "] must be exactly the same size."
  exit
end

#####
# Don't overwrite existing file. 
#####
if File.exists?(ofn)
  puts "Output file: [" + ofn + "] already exists. Will not overwrite."
  exit
end

#####
# Now, open our XOR input file(rb) and output file(wb). 
#####
xor_input_fd = File.open(xfn, 'rb')
output_fd    = File.open(ofn, 'wb')

#####
# Earlier, we have already established that the input file and input XOR file are exactly
# the same size. So, when we read from one, we can safely read from the other.
#####
File.open(ifn, 'rb') do |input_fd|
  until input_fd.eof?
    input_byte     = input_fd.read(1)
    xor_input_byte = xor_input_fd.read(1)
    # Write the XORed byte out.
    output_fd.write((input_byte.to_i(2)) ^ (xor_input_byte.to_i(2)))
  end
end

puts "\nDone generating output file: [" + ofn + "]"
puts "===========================================================================================\n"
exit

################################################################################
################################# EOF ##########################################
################################################################################
