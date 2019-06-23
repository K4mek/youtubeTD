require "open-uri"

class ThumbnailDownloader
	def load_id id
		if id.class.to_s == "Array"
			@id = id
			return self
		else
			raise(Exception, "this isn't array")
		end
	end

	def download
		unless defined? @id then
			raise(Exception, "variable @id ins't defined")
		end
		@current_id = nil
		begin
			@id.each do |ids|
				@current_id = ids
				url = "https://i.ytimg.com/vi/"+ids+"/maxresdefault.jpg"
				file_size = 0
				progress = {
					:content_length_proc => -> (length) do
						file_size = length
					end,
					:progress_proc => -> (pro) do
						print "#{ids} => #{pro/1000}/#{file_size/1000} KiBs    \r"
					end
				}
				open(url, progress) do |request|
					File.open("#{ids}.jpg", "wb") do |file|
						file.write request.read
					end
				end
				puts "#{ids} => #{file_size/1000}/#{file_size/1000} KiBs    \r"
			end	
		rescue OpenURI::HTTPError => error
			puts "#{@current_id} => #{error.message}"
		rescue SocketError => error 
			puts "unknow host"
		end	
	end
end