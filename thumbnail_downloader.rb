require "open-uri"

class ThumbnailDownloader
	def load_id id
		if id.class.to_s == "Array" then
			@id = id
		else
			raise(Exception, "this isn't array")
		end
	end

	def download_from_file file
		File.open(file, "r") do |input|
			output = nil
			while(output = input.readline rescue nil) do
				output.chomp!
				url = "https://i.ytimg.com/vi/"+output+"/maxresdefault.jpg"
				file_size = 0
				progress = {
					:progress_proc => lambda {|pro|
						print "#{output} => #{pro/1000}KBs    \r"
					},
					:content_length_proc => lambda {|length|
						file_size = length
					}	
				}
				thing = open(url, progress) do |request|
					File.open("#{output}.jpg", "wb") do |writer|
						writer.write request.read
					end
				end rescue nil
				puts (thing)? "#{output} => #{file_size/1000}KBs    \r": "#{output} => 404 Not Found" 
			end
		end
	end
	private :download_from_file	

	def download
		unless defined? @id then
			raise(Exception, "variable @id ins't defined")
		end
		return download_from_file @id.join if File.file? @id.join 
		begin
			@id.each do |ids|
				url = "https://i.ytimg.com/vi/"+ids+"/maxresdefault.jpg"
				file_size = 0
				progress = {
					:progress_proc => lambda {|pro|
						print "#{ids} => #{pro/1000}KBs    \r"
					},
					:content_length_proc => lambda {|length|
						file_size = length
					}	
				}
				open(url, progress) do |request|
					File.open("#{ids}.jpg", "wb") do |file|
						file.write request.read
					end
				end
				puts "#{ids} => #{file_size/1000}KBs    \r"
			end	
		rescue OpenURI::HTTPError => error
			puts "'#{ids}' #{error.message}"
		end	
	end
end