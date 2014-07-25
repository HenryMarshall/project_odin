# fd = IO.sysopen("new-fd", "w")
# p IO.new(fd)

io_streams = Array.new
ObjectSpace.each_object(IO) { |x| io_streams << x }
io_streams.each { |x| p x }

