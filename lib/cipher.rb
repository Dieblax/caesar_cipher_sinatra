require "sinatra"
require "sinatra/reloader" if development?

def caesar_cipher(s, k)
	s = s.split("")
	for i in (0...s.size) do 
		ascii = s[i].ord
		if ((65..90) === ascii) 
			j = (ascii - 65 + k)%26 + 65 
			s[i] = j.chr
		elsif ((97..122) === ascii.ord)
			j = (ascii - 97 + k)%26 + 97 
			s[i] = j.chr
		end
	end
	s = s.join("")
	return s
end

get "/" do

	text = params["text"]
	key = params["key"].to_i
	encrypted, decrypted = false
	encrypt = true if params["encrypt"]
	decrypt = true if params["decrypt"]

	if encrypt
		result = caesar_cipher(text, key)
	elsif decrypt
		result = caesar_cipher(text, -1 * key)
	else
		result = nil
	end
	halt result
	erb :index, :locals => {:result => result, :key => key, :encrypted => encrypt, :decrypted => decrypt}
end