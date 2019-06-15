require_relative "thumbnail_downloader"

downloader = ThumbnailDownloader.new
downloader.load_id(ARGV).download