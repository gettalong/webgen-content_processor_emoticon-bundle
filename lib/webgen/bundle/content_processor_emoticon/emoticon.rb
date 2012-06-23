# -*- encoding: utf-8 -*-

require 'webgen/content_processor'
require 'webgen/tag/relocatable'

module Webgen
  class ContentProcessor

    # Replaces text emoticons with picture emoticons.
    module Emoticon

      UNICODE_MAP = {
        ':-@' => "\u{1f620}",
        '8-)' => "\u{1f60e}",
        ':\'-(' => "\u{1f622}",
        ':*)' => "\u{1f635}",
        ':-D' => "\u{1f604}",
        ':-O' => "\u{1f633}",
        ':-(' => "\u{1f61e}",
        '|-I' => "\u{1f634}",
        ':-)' => "\u{1f603}",
        ':)'  => "\u{1f603}",
        ':-P' => "\u{1f61b}",
        ';-)' => "\u{1f609}",
      }

      EMOTICON_MAP = {
        ':-@' => 'angry',
        '8-)' => 'cool',
        ':\'-(' => 'cry',
        ':*)' => 'drunk',
        ':-D' => 'lol',
        ':-O' => 'oops',
        ':-(' => 'sad',
        '|-I' => 'sleep',
        ':-)' => 'smile',
        ':)'  => 'smile',
        ':-P' => 'tongue',
        ';-)' => 'wink'
      }
      EMOTICON_REGEXP = Regexp.union(*EMOTICON_MAP.keys.collect {|t| /#{Regexp.escape(t)}/ } )
      SEARCH_REGEXP = /<(pre|code|script|style).*?>.*?#{EMOTICON_REGEXP}.*?<\/\1\s*>|#{EMOTICON_REGEXP}/

      def self.call(context) #:nodoc:
        theme = emoticon_theme(context)
        return context if theme.nil?

        prefix = "/images/emoticons/#{theme}/"
        context.content.gsub!(SEARCH_REGEXP) do |match|
          if $1.nil? && theme == 'unicode'
            UNICODE_MAP[match]
          elsif $1.nil? && (path = Webgen::Tag::Relocatable.resolve_path("#{prefix}#{EMOTICON_MAP[match]}.png", context)) != ''
            "<img src=\"#{path}\" alt=\"emoticon #{match}\" />"
          else
            match
          end
        end

        context
      end

      # Return the emoticon theme for the given context.
      #
      # Uses the reference node to determine the emoticon theme to use.
      def self.emoticon_theme(context)
        node = context.ref_node
        if node.meta_info.has_key?('emoticon_theme')
          node['emoticon_theme'].nil? ? nil : node['emoticon_theme']
        else
          context.website.config['content_processor.emoticon.theme']
        end
      end

    end

  end
end
