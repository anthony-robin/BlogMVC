module JsonLdHelper
  # Professional service entity
  #
  # @return [JSON]
  def jsonld_professional_service
    {
      '@context': 'http://schema.org',
      '@type': 'ProfessionalService',
      url: root_url,
      name: website_conf['title'],
      legalName: website_conf['title']
    }.to_json.html_safe
  end

  # Blog entity
  #
  # @param blog [Blog]
  # @return [JSON]
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

  # Comment entity
  #
  # @param comment [Comment]
  # @return [JSON]
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

  # Pagination entity
  #
  # TODO: Find a way to test this method
  # @param blogs [ActiveRecord::Relation<Blog>]
  # @return [JSON]
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

  # Person entity
  #
  # @param author [User]
  # @return [Hash]
  def jsonld_author(author)
    {
      author: {
        '@type' => 'Person',
        name: author.username
      }
    }
  end

  # Publisher entity
  #
  # @return [Hash] website title
  def jsonld_publisher
    {
      name: website_conf['title']
    }
  end
end
