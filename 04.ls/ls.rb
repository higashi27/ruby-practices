# frozen_string_literal: true

require 'optparse'

def prepare_file_listing
  @number_of_columns = 3
  sort_files
end

def sort_files
  sorted_files = @files.sort

  sorted_files << nil while sorted_files.size % @number_of_columns != 0

  count_row = sorted_files.size / @number_of_columns
  files_slice = sorted_files.each_slice(count_row).to_a
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
no_arguments_provided = true

opt.on('-a') do
  @files = Dir.entries('.')
  prepare_file_listing
  output_files
  no_arguments_provided = false
end

if ARGV.empty?
  no_arguments_provided = true
else
  opt.parse!(ARGV)
end

if no_arguments_provided
  @files = Dir.glob('*')
  prepare_file_listing
  output_files
end
