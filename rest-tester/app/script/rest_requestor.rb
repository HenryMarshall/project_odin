require 'rest-client'
url = "http://localhost:3000/users"
url_id = "#{url}/1"

# index
puts RestClient.get(url)
# show
puts RestClient.get(url_id)
# new
puts RestClient.get("#{url}/new")
# edit
puts RestClient.get("#{url_id}/edit")

# create
puts RestClient.post(url, "")
# update
puts RestClient.update(url_id, "")
# destroy
puts RestClient.destory(url_id)