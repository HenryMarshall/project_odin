# fd = IO.sysopen("new-fd", "w")
# p IO.new(fd)

io_streams = Array.new
ObjectSpace.each_object(IO) { |x| io_streams << x }
io_streams.each { |x| p x }

# read all lines to an array
  File.open("sample.txt").readlines.each do |line|
    puts line
  end

# eof? returns true when "end of file"
file = File.open("sample.txt")
until file.eof?
  # for long files or with many users best practice is to read lines only
  # when you need them (i.e., with readline, not with readlines)
  line = file.readline
  puts line
end