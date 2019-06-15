# command line
ruby yte.rb id1, id2, ...

# embedding
    require_relative "ThumbnailDownloader"
    
    video_ids = ["video_id1", "video_id2", "..."]
    downloader = ThumbnailDownloader.new
    downloader.load_id(video_ids).download
