require "uri"
require "open-uri"

class ThumbnailDownloader
	def load_id id
		if id.class.to_s == "Array" then
			@id = id
		else
			raise(Exception, "this isn't array")
		end
	end

	def download_file
		unless defined? @id then
			raise(Exception, "variable @id ins't defined")
		end
		file_count = file_size = 0
		progress = {
			:progress_proc => lambda {|pro|
				print "image#{file_count} => #{pro/1000}KBs    \r"
			},
			:content_length_proc => lambda {|length|
				file_size = length
			}	
		}
		@id.each do |ids|
			begin
				file_count += 1
				url = "https://i.ytimg.com/vi/"+ids+"/maxresdefault.jpg" 
				open(url, progress) do |request|
					File.open("image#{file_count}.jpg", "wb") do |file|
						file.write request.read
					end
				end
				puts "image#{file_count} => #{file_size/1000}KBs    \r"
			rescue OpenURI::HTTPError => error
				puts "'#{ids}' #{error.message}"
			end
		end	
	end
end