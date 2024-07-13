# frozen_string_literal: true

require 'optparse'

NUMBER_OF_COLUMNS = 3

def prepare_file_listing(sorted_files)
  sorted_files << nil while sorted_files.size % NUMBER_OF_COLUMNS != 0

  count_row = sorted_files.size / NUMBER_OF_COLUMNS
  files_slice = sorted_files.each_slice(count_row).to_a
  transposed_files = files_slice.transpose
  transposed_files
end

def output_files(files, transposed_files)
  max_filename = files.map(&:length).max
  transposed_files.each do |file|
    removed_nil_files = file.compact
    aligned_files = removed_nil_files.map { |g| g.ljust(max_filename, ' ') }
    puts aligned_files.join('  ')
  end
end

opt = OptionParser.new
params = {}

opt.on('-a') { |v| params[:a] = v }
opt.on('-r') { |v| params[:r] = v }

opt.parse!(ARGV)

files = params[:a] ? Dir.entries('.') : Dir.glob('*')
sorted_files = params[:r] ? files.sort.reverse : files.sort
transposed_files = prepare_file_listing(sorted_files)

output_files(files, transposed_files)
