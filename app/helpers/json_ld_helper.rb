module JsonLdHelper
  def jsonld_professional_service
    {
      '@context': 'http://schema.org',
      '@type': 'ProfessionalService',
      url: root_url,
      name: 'BlogMVC',
      legalName: 'BlogMVC'
    }.to_json.html_safe
  end

  def jsonld_blog(blog)
    serialized = {
      '@context': 'http://schema.org',
      '@type': 'BlogPosting',
      headline: blog.title,
      image: blog.picture? ? blog.picture.image.url(:large) : nil,
      genre: blog.tag_list.join(','),
      keywords: blog.title.split().join(','),
      wordcount: blog.content.split.size,
      url: category_blog_url(blog.category, blog),
      datePublished: blog.created_at,
      dateCreated: blog.created_at,
      dateModified: blog.updated_at,
      description: blog.content,
      articleBody: blog.content,
      comment_count: blog.comments_count
    }

    serialized.merge!(jsonld_publisher)
    serialized.merge!(jsonld_author(blog.user))
    serialized.to_json.html_safe
  end

  def jsonld_comment(comment)
    serialized = {
      '@context': 'http://schema.org',
      '@type': 'Comment',
      dateCreated: comment.created_at,
      text: comment.body
    }

    serialized.merge!(jsonld_author(comment.user))
    serialized.to_json.html_safe
  end

  # TODO: Find a way to test this method
  def json_ld_blogs_paginator(blogs)
    {
      '@id': request.original_url,
      '@type': 'Page',
      firstPage: blogs_path(page: 1),
      previousPage: path_to_prev_page(blogs),
      nextPage: path_to_next_page(blogs),
      lastPage: blogs_path(page: blogs.total_pages)
    }.to_json.html_safe
  end

  private

  def jsonld_author(author)
    {
      author: {
        '@type' => 'Person',
        name: author.username
      }
    }
  end

  def jsonld_publisher
    {
      name: 'BlogMVC'
    }
  end
end
