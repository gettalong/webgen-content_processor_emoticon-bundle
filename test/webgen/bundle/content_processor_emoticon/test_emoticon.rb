# -*- encoding: utf-8 -*-

require 'webgen/test_helper'
require 'webgen/bundle/content_processor_emoticon/emoticon'

class TestEmoticon < MiniTest::Unit::TestCase

  include Webgen::TestHelper

  def test_static_call
    setup_website('content_processor.emoticon.theme' => 'def')
    @website.ext.item_tracker = Object.new
    def (@website.ext.item_tracker).add(*args); end

    root = Webgen::Node.new(Webgen::Tree.new(@website).dummy_root, '/', '/')
    node = Webgen::Node.new(root, 'somefile.png', '/images/emoticons/def/smile.png')

    context = Webgen::Context.new(@website, :chain => [root], :config => @website.config)
    cp = Webgen::ContentProcessor::Emoticon

    content = "<script with='arg'>some :-) test</script><pre>;-)</pre> and her :) too"

    context.content = content.dup
    assert_equal("<script with='arg'>some :-) test</script><pre>;-)</pre> and her <img src=\"images/emoticons/def/smile.png\" alt=\"emoticon :)\" /> too",
                 cp.call(context).content)

    root.meta_info['emoticon_theme'] = nil
    context.content = content.dup
    assert_equal(content, cp.call(context).content)

    root.meta_info['emoticon_theme'] = 'unicode'
    context.content = content.dup
    assert_equal("<script with='arg'>some :-) test</script><pre>;-)</pre> and her \u{1f603} too",
                 cp.call(context).content)

    root.meta_info['emoticon_theme'] = 'unknown'
    context.content = content.dup
    assert_equal(content, cp.call(context).content)
  end

end
