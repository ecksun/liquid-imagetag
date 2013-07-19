require 'src/common.rb'
require 'test/unit'

class CommonTest < Test::Unit::TestCase
    def test_url_render
        common = Jekyll::Common.new('http://a.url/image.png')
        expected = <<-eos
<figure>
<img src="http://a.url/image.png" />
</figure>
        eos

        result = common.render()
        assert_without_newlines(expected, result)
    end

    def test_url_render_thumb
        common = Jekyll::Common.new('http://a.url/image.png thumb')

        expected = <<-eos
<figure>
<a href="http://a.url/image.png">
<img src="http://a.url/image-thumb.png" />
</a>
</figure>
        eos

        assert_without_newlines(expected, common.render())
    end

    def test_with_figure_class()
        common = Jekyll::Common.new('someClass http://a.url/image.png')
        expected = <<-eos
<figure class="someClass">
<img src="http://a.url/image.png" />
</figure>
        eos
        assert_without_newlines(expected, common.render())
    end

    def test_with_caption()
        common = Jekyll::Common.new('http://a.url/image.png')
        common.set_caption('This is a long caption')
        expected = <<-eos
<figure>
<img src="http://a.url/image.png" alt="This is a long caption" />
<figcaption>This is a long caption</figcaption>
</figure>
        eos
        assert_without_newlines(expected, common.render())
    end

    def test_title()
        common = Jekyll::Common.new('http://a.url/image.png title="The Title"')
        expected = <<-eos
<figure>
<img src="http://a.url/image.png" title="The Title" />
</figure>
        eos
        assert_without_newlines(expected, common.render())
    end

    def test_title_and_caption()
        common = Jekyll::Common.new('http://a.url/image.png title="a TITLE"')
        common.set_caption('This is a long caption')
        expected = <<-eos
<figure>
<img src="http://a.url/image.png" alt="This is a long caption" title="a TITLE" />
<figcaption>This is a long caption</figcaption>
</figure>
        eos
        assert_without_newlines(expected, common.render())
    end


    def assert_without_newlines(expected, result)
        assert_equal(expected.gsub(/[\r\n]/, ''), result.gsub(/[\r\n]/, ''))
    end
end
