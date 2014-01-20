require(File.dirname(__FILE__) + '/common.rb')

module Jekyll
  class ImageTag < Liquid::Tag
    @common = nil
    def initialize(tag_name, markup, tokens)
      super
      @common = Common.new(markup)
    end

    def render(context)
      if context.registers[:site].config['baseurl']
        @image_tag.set_baseurl(context.registers[:site].config['baseurl'])
      end
      @common.render()
    end
  end

  class ImageBlock < Liquid::Block
    @image_tag = nil
    def initialize(tag_name, markup, tokens)
      super
      @image_tag = Common.new(markup)
    end

    def render(context)
      if context.registers[:site].config['baseurl']
        @image_tag.set_baseurl(context.registers[:site].config['baseurl'])
      end
      @image_tag.set_caption(super)
      @image_tag.render()
    end
  end
end

Liquid::Template.register_tag('captionimage', Jekyll::ImageBlock)
Liquid::Template.register_tag('image', Jekyll::ImageTag)
