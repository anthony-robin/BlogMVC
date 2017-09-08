module ButtonsHelper
  # Button for adding a resource.
  #
  # @param path [Url] url to add resource
  def add_button_to(path, text = t('add'))
    link_to path, class: 'button small success' do
      concat text
    end
  end

  # Button for going back to a specific page.
  #
  # @param path [Url] url to return to
  # @option text [String] text to display inside button
  def back_button_to(path, text = t('back'))
    link_to path, class: 'button small secondary' do
      concat text
    end
  end

  # Button for destroying a resource.
  #
  # @param path [Url] url to destroy resource
  def destroy_button_to(path, text = t('destroy'))
    link_to path,
      class: 'button small alert',
      data: { confirm: t('are_you_sure') },
      method: :delete do
      concat text
    end
  end

  # Button for editing a resource.
  #
  # @param path [Url] url to edit resource
  def edit_button_to(path, text = t('edit'))
    link_to path, class: 'button small warning' do
      concat text
    end
  end

  # Button for showing a resource.
  #
  # @param path [Url] url to show resource
  def show_button_to(path, text = t('show'))
    link_to path, class: 'button small' do
      concat text
    end
  end
end
