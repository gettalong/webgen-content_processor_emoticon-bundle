# -*- encoding: utf-8 -*-

require 'minitest/autorun'
require 'webgen/bundle/content_processor_emoticon/emoticon'
require 'webgen/node'
require 'webgen/tree'
require 'webgen/context'
require 'logger'
require 'stringio'

class TestEmoticon < MiniTest::Unit::TestCase

  def test_static_call
    website = MiniTest::Mock.new
    website.expect(:ext, OpenStruct.new)
    website.expect(:logger, Logger.new(StringIO.new))
    website.expect(:config, {'content_processor.emoticon.theme' => 'def'})
    website.ext.item_tracker = MiniTest::Mock.new
    def (website.ext.item_tracker).add(*args); end

    root = Webgen::Node.new(Webgen::Tree.new(website).dummy_root, '/', '/')
    node = Webgen::Node.new(root, 'somefile.png', '/images/emoticons/def/smile.png')

    context = Webgen::Context.new(website, :chain => [root])
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
