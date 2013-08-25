require_relative('emoticon')

website.ext.content_processor.register('Emoticon')

option('content_processor.emoticon.theme', nil)

mount_passive('emoticons/', '/images/emoticons/', '**/')
