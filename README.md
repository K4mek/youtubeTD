## Embedding
``` ruby
    require_relative "ThumbnailDownloader"
    
    video_ids = ["video_id1", "video_id2", "..."]
    downloader = ThumbnailDownloader.new
    downloader.load_id(video_ids).download
```
