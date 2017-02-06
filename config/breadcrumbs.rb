crumb :root do
  link t('homes.index.title'), root_path
end

# -----------
# Blog
#------------
crumb :blogs do
  link t('blogs.index.title'), blogs_path
end

crumb :category do |category|
  link category.name, category_blogs_path(category)
  parent :blogs
end

crumb :blog do |blog|
  link blog.title, category_blog_path(blog.category, blog)
  parent blog.category
end

# -----------
# User
#------------
crumb :show_own_profile do
  link t('users.index.title', profile: current_user.username), users_path
end

crumb :create_own_profile do
  link t('devise.registrations.new.title'), '#'
end

crumb :update_own_profile do
  link t('devise.registrations.edit.title'), '#'
end

crumb :user do |user|
  link t('users.show.title', profile: user.username), user_path(user)
end
