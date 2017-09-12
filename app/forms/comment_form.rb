class CommentForm < ApplicationForm
  model :comment

  property :body, validates: { presence: true }
  property :user, validates: { presence: true }
  property :nickname, validates: { absence: true }
end
