# frozen_string_literal: true

require 'optparse'

def prepare_file_listing
  number_of_columns = 3
  @sorted_files << nil while @sorted_files.size % number_of_columns != 0

  count_row = @sorted_files.size / number_of_columns
  files_slice = @sorted_files.each_slice(count_row).to_a
  @transposed_files = files_slice.transpose
end

def output_files
  max_filename = @files.map(&:length).max
  @transposed_files.each do |file|
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

@files = params[:a] ? Dir.entries('.') : Dir.glob('*')
@sorted_files = params[:r] ? @files.sort.reverse : @files.sort
prepare_file_listing
output_files
