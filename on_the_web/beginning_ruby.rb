# require 'net/http'
# Net::HTTP.start('www.rubyinside.com') do |http|
#   req = Net::HTTP::Get.new('/test.txt')
#   puts http.request(req).body
# end

# url = URI.parse('http://www.rubyinside.com/test.txt')
# Net::HTTP.start(url.host, url.port) do |http|
#   req = Net::HTTP::Get.new(url.path)
#   puts http.request(req).body
# end

# # equivalent to
#   response = Net::HTTP.get_response(url)
#   puts response.body

# def get_web_document url
#   uri = URI.parse(url)
#   response = Net::HTTP.get_response(uri)

#   case response
#   when Net::HTTPSuccess
#     return response.body
#   when Net::HTTPRedirection
#     return get_web_document(response['Location'])
#   else
#     return nil
#   end
# end

# puts get_web_document('http://www.rubyinside.com/test.txt')
# puts get_web_document('http://www.rubyinside.com/non-existant')
# puts get_web_document('http://www.rubyinside.com/redirect-test')

# url = URI.parse('http://browserspy.dk/password-ok.php')
# Net::HTTP.start(url.host, url.port) do |http|
#   req = Net::HTTP::Get.new(url.path)
#   req.basic_auth('test', 'test')
#   puts http.request(req).body
# end

# url = URI.parse('http://www.rubyinside.com/test.cgi')
# response = Net::HTTP.post_form(url, {'name'=>'David', 'age'=>'6000'})
# puts response.body

# require 'net/http'
# require 'net/https'

# url = URI.parse('https://example.com/')
# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true if url.scheme == 'https'
# request = Net::HTTP::Get.new(url.path)
# puts http.request(request).body

require 'open-uri'
# f = open('http://www.rubyinside.com/test.txt')
# puts f.readlines.join
# puts "The document is #{f.size} bytes in length"

# puts URI.parse('http://www.rubyinside.com/test.txt').open.read

f = open('http://www.rubyinside.com/test.txt', {'User-Agent' => 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0'})
puts f.read
puts f.content_type
puts f.charset
puts f.last_modified