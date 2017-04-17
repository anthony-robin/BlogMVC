json.array! @blogs.records do |blog|
  json.title blog.title
  json.url category_blog_path(blog.category, blog)
  json.picture retina_image_tag(blog.picture, :image, :thumb) if blog.picture?
end
