class BatchMailer < ApplicationMailer

  def create_item(item, recipients = [])
    @item = item
    @pending_items = @item.list.items.where(date_completed: nil)
    builder = batch_builder()
    builder.subject("New Item Added to #{@item.list.title.titleize}")
    set_templates(builder, @item, "batch_mailer/create_item")
    add_recipients(builder, @item, recipients)

    builder.finalize
  end

  def item_status(item, recipients = [])
    @item = item
    @pending_items = @item.list.items.where(date_completed: nil)
    if @item.date_completed.present?
      @status = 'was completed'
    else
      @status = 'is incomplete'
    end
    builder = batch_builder()
    builder.subject("#{@item.title.titleize} #{@status}")
    set_templates(builder, @item, "batch_mailer/item_status")
    add_recipients(builder, @item, recipients)

    builder.finalize
  end

  def list_completed(list, recipients = [])
    @list = list

    builder = batch_builder()
    builder.subject("Congratulations #{@list.title.titleize} has been completed")
    set_templates(builder, @list, "batch_mailer/list_completed")
    add_recipients(builder, @list, recipients)

    builder.finalize
  end

  protected

  def set_templates(mail_object, resource, action)
    # Render html version
    html = render_to_string(
      template: action,
      formats: [:html],
      locals: { request: resource }
    )

    # Render plain text version
    txt = render_to_string(
      template: action,
      formats: [:text],
      # layout: false,
      locals: { request: resource }
    )

    mail_object.body_text(txt.to_str)
    mail_object.body_html(html.to_str)
  end

  def add_recipients(mail_object, resource, recipients)
    recipients.each do |user|
        mail_object.add_recipient(:to, user.email, 'name' => user.name,
                                               'account-id' => user.id)
    end
  end
end
