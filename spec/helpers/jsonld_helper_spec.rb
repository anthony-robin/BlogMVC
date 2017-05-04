require 'rails_helper'

describe JsonLdHelper do
  include ApplicationHelper
  include Kaminari::Helpers::HelperMethods

  describe '#jsonld_professional_service' do
    it 'has correct json body' do
      expected = {
        '@context': 'http://schema.org',
        '@type': 'ProfessionalService',
        url: root_url,
        name: 'BlogMVC',
        legalName: 'BlogMVC'
      }.to_json

      expect(jsonld_professional_service).to eq expected
    end
  end

  describe '#jsonld_blog' do
    let(:blog) { create(:blog) }

    it 'has correct json body' do
      expected = {
        '@context': 'http://schema.org',
        '@type': 'BlogPosting',
        headline: blog.title,
        image: nil,
        genre: blog.tag_list.join(','),
        keywords: blog.title.split().join(','),
        wordcount: blog.content.split.size,
        url: category_blog_url(blog.category, blog),
        datePublished: blog.created_at,
        dateCreated: blog.created_at,
        dateModified: blog.updated_at,
        description: blog.content,
        articleBody: blog.content,
        comment_count: blog.comments_count,
        name: 'BlogMVC',
        author: {
          '@type' => 'Person',
          name: blog.user.username
        }
      }.to_json

      expect(jsonld_blog(blog)).to eq expected
    end
  end

  describe '#jsonld_comment' do
    let(:comment) { create(:comment) }

    it 'has correct json body' do
      expected = {
        '@context': 'http://schema.org',
        '@type': 'Comment',
        dateCreated: comment.created_at,
        text: comment.body,
        author: {
          '@type' => 'Person',
          name: comment.user.username
        }
      }.to_json

      expect(jsonld_comment(comment)).to eq expected
    end
  end

  describe '#json_ld_blogs_paginator' do
    let(:blogs) { create_list(:blog, 5) }
    let(:request) { view.request }

    it 'has correct json body' do
      blogs = Blog.all.page params[:page]

      expected = {
        '@id': 'http://test.host',
        '@type': 'Page',
        firstPage: blogs_path(page: 1),
        previousPage: view.path_to_prev_page(blogs),
        nextPage: view.path_to_next_page(blogs),
        lastPage: blogs_path(page: blogs.total_pages)
      }.to_json

      expect(json_ld_blogs_paginator(blogs)).to eq expected
    end
  end
end
