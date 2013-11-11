# Emoticon support for webgen

This is a [webgen] extension bundle that provides a content processor
named `emoticon` for converting text emoticons to image emoticons.
Furthermore, some emoticon themes are also provided out of the box.

[webgen]: http://webgen.gettalong.org


# Usage

First you need to load the emoticon content processor bundle and,
optionally, an image emoticon theme, see [Installation](#installation)
below.

After that you have to add the `emoticon` content processor to a
processing pipeline, for example, the one for page files:

    path_handler.default_meta_info:
      page:
        blocks:
          :default:
            pipeline: erb,tags,kramdown,blocks,fragments,emoticon

If you generate your website after this change, you won't find any
changes since no emoticon theme is set by default. If you wish to enable
emoticon conversion on all pages, use the configuration option
`content_processor.emoticon.theme` and set it to the theme you want to
use. The 'unicode' theme is available out-of-the box. If you want to use
an image emoticon theme, don't forget to load the theme!

You can also enable or disable emoticon conversion on a page-to-page
basis by using the `emoticon_theme` meta information key. If this key is
specified, it takes precedence over the configuration option.

The content processor is smart enough to not convert emoticons that are
inside `pre`, `code`, `style` and `script` tags.


# Available emoticons

    :-@    angry
    8-)    cool
    :'-(   cry
    :*)    drunk
    :-D    lol
    :-O    oops
    :-(    sad
    |-I    sleep
    :-)    smile
    :)     smile
    :-P    tongue
    ;-)    wink


You can see all available image emoticon themes at
<https://github.com/gettalong/webgen-content_processor_emoticon-bundle/wiki>


# Custom emoticon themes

If you want to create a custom emoticon theme, it is recommended to name
the bundle `emoticon-theme-MYTHEME`.

Use webgen's built-in command for creating a new extension bundle, put
your emoticon images into the directory
`emoticon-theme-MYTHEME/emoticons` and the following into the `init.rb`
file:

    mount_passive('emoticons/', '/images/emoticons/MYTHEME/')

Note that all emoticon images have to be in the PNG format!


# Installation

The easiest way to install this extension bundle is by installing the
corresponding Rubygem:

    gem install webgen-content_processor_emoticon-bundle

If you don't use Rubygems, copy all folders under `lib/webgen/bundle/`
into your `ext` directory.

After that you just need to tell webgen to use the new content processor
extension by adding the following line to your `ext/init.rb` file:

    load("content_processor_emoticon")

After that the content processor is available and uses the standard
'unicode' theme. The following statement loads one of the provided
image emoticon themes:

    load("emoticon-theme-bigeyes")


# Copyright and license

## The whole package

The package is licensed under the GPLv3 since two of the emoticon themes
have this license.


## Content Processor emoticon

I.e. all files under `lib/webgen/bundle/content_processor_emoticon`.

Copyright (c) 2013 Thomas Leitner under the MIT license (see LICENSE-MIT)


## Emoticon themes

See the information in the `info.yaml` files for information regarding
the license of each emoticon theme.
