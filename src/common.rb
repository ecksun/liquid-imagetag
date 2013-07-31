module Jekyll
  class Common
    @url = nil
    @caption = nil
    @class = nil
    @title = nil
    @thumb = false
    @baseurl = ""

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

    def set_baseurl(baseurl)
      @baseurl = baseurl
    end

    def render()
      source = "\n"
      if @class
        source += "<figure class=\"#{@class}\">"
      else
        source += "<figure>\n"
      end

      source += "<a href=\"#{ @baseurl }#{@url}\">\n" if @thumb
      source += "<img src=\"#{ @baseurl }#{ @thumb ? get_thumb(@url) : @url}\" " + (@caption ? "alt=\"#{@caption}\" ":"") + (@title ? "title=\"#{@title}\" " : "") + "/>\n"
      source += "</a>\n" if @thumb
      source += "<figcaption>#{@caption}</figcaption>\n" if @caption
      source += "</figure>\n"

      source
    end

    def get_thumb(filename)
        filename.gsub(%r{(\.[\w\d]+)$}, '-thumb\1')
    end
  end
end
