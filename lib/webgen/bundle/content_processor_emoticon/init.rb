require_relative('emoticon')

website.ext.content_processor.register('Emoticon')

option('content_processor.emoticon.theme', nil,
       "The name of an image emoticon theme, unicode (for text emoticons) or nil")

mount_passive('emoticons/', '/images/emoticons/', '**/')
