# Image Tag
# TODO Fix below
#
# Easily put an image into a Jekyll page or blog post
#
# Examples:
#   Input:
#     {% image http://path/to/image.png %}
#   Output:
#      <figure>
#        <img src='http://path/to/image.png'>
#      </figure>
#
#   Input:
#     {% image full http://path/to/image.png %}
#   Output:
#      <figure class='full'>
#        <img src="http://path/to/image.png">
#      </figure>
#
#   Input:
#     {% image http://path/to/image.png "Image caption" %}
#   Output:
#      <figure>
#        <img src="http://path/to/image.png">
#        <figcaption>Image caption</figcaption>
#      </figure>
#
#   Input:
#     {% image full http://path/to/image.png "Image caption" %}
#   Output:
#      <figure class='full'>
#        <img src="http://path/to/image.png">
#        <figcaption>Image caption</figcaption>
#      </figure>

# module Liquid
#   class Tag
#     def initialize(a, b, c)
#     end
#   end
#   class Block
#     def initialize(a, b, c)
#     end
#     def render(asdf)
#       "hejsan"
#     end
#   end
#   class Template
#     def self.register_tag(a, b)
#     end
#   end
# end

module Jekyll
  class Common
    @url = nil
    @caption = nil
    @class = nil
    @title = nil
    @thumb = false

    IMAGE_URL_WITH_CLASS = /(\w+)(\s+)((https?:\/\/|\/)(\S+))/i
    IMAGE_URL = /((https?:\/\/|\/)(\S+))/i

    TITLE_TEXT = /title="(.*)"/i

    def initialize(markup)
      if markup =~ IMAGE_URL_WITH_CLASS
        @class = $1
        @url   = $3
      elsif markup =~ IMAGE_URL
        @url = $1
      end
      if markup =~ TITLE_TEXT
        @title = $1
      end
      if markup =~ /thumb/i
        @thumb = true
      end
    end

    def set_caption(caption)
      @caption = caption
    end

    def render()
      source = "\n"
      if @class
        source += "<figure class='#{@class}'>"
      else
        source += "<figure>"
      end

      source += "<a href=\"#{@url}\" >" if @thumb
      source += "<img src=\"#{ @thumb ? get_thumb(@url) : @url}\" " + (@caption ? "alt=\"#{@caption}\" ":"") + (@title ? " title=\"#{@title}\" " : "") + ">"
      source += "</a>" if @thumb
      source += "<figcaption>#{@caption}</figcaption>" if @caption
      source += "</figure>"
      source += "\n"

      source
    end
  end

  class ImageTag < Liquid::Tag
    @common = nil
    def initialize(tag_name, markup, tokens)
      super
      @common = Common.new(markup)
    end

    def render(context)
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
      @image_tag.set_caption(super)
      @image_tag.render()
    end
  end
end


def get_thumb(filename)
  filename.gsub(%r{(\.[\w\d]+)$}, '-thumb\1')
end

# a = Jekyll::ImageBlock.new("a", "b", "c")
# a.render("asdf")
#
# a = Jekyll::ImageTag.new("a", "b", "c")
# a.render("asdf")

Liquid::Template.register_tag('captionimage', Jekyll::ImageBlock)
Liquid::Template.register_tag('image', Jekyll::ImageTag)
