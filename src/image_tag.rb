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

require('common.rb')

module Jekyll
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

Liquid::Template.register_tag('captionimage', Jekyll::ImageBlock)
Liquid::Template.register_tag('image', Jekyll::ImageTag)
