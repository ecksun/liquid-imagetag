# Image Tag

Easily put an image into a Jekyll page or blog post

There is two tags to use, image and captionimage. captionimage is a block tag
and takes the image caption in the block contents while image just generates
a figure with a given class, title and thumb, if given.

The class have to proceed the link, the caption comes after. If the word
"thumb" is included anywhere in the string, the URL will have '-thumb'
prefixed before the file ending (/image.png -> /image-thumb.png) and the image
will be clickable, with the link leading to the full sized image

This builds upon
[image_tag.rb](https://github.com/stewart/blog/blob/master/plugins/image_tag.rb) from Andrew
Stewart

## Examples
### Input:
```
{% image http://path/to/image.png %}
```
### Output:
```
     <figure>
       <img src='http://path/to/image.png'>
     </figure>
```

### Input:
```
    {% image full http://path/to/image.png %}
```
### Output:
```
     <figure class='full'>
       <img src="http://path/to/image.png">
     </figure>
```

### Input:
```
    {% captionimage http://path/to/image.png  %}Image caption{% endcaptionimage %}
```
### Output:
```
     <figure>
       <img src="http://path/to/image.png">
       <figcaption>Image caption</figcaption>
     </figure>
```

### Input:
```
    {% image full http://path/to/image.png "Image caption" thumb %}
```
### Output:
```
     <figure class='full'>
       <a href="http://path/to/image.png">
       <img src="http://path/to/image-thumb.png">
       </a>
       <figcaption>Image caption</figcaption>
     </figure>
```

