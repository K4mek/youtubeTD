require_relative "tumbnail_downloader"

downloader = ThumbnailDownloader.new
downloader.load_id ARGV
downloader.download_file