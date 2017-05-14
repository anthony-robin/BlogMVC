class ContactsController < ApplicationController
  before_action :set_form, only: %i[new create]

  # GET /contacts
  def index
    redirect_to new_contact_path
  end

  # GET /contacts/new
  def new
    add_breadcrumb t('.title'), new_contact_path
  end

  # POST /contacts
  def create
    if @form.validate(params[:contact])
      ContactMailer.send_email(params[:contact]).deliver_now
      ContactMailer.copy_email(params[:contact]).deliver_now if params[:contact][:copy] == '1'

      redirect_to new_contact_url, notice: t('.notice')
    else
      render :new
    end
  end

  private

  def set_form
    @form = ContactForm.new
  end
end
