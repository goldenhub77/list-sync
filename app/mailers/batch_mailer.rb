class BatchMailer < ApplicationMailer

  def item_create(item, recipients = [])
    @item = item
    @user = item.user
    builder = batch_builder()
    builder.subject("New Item Added to list #{@item.list.title.titleize}")

    # Render html version
    html = render_to_string(
      template: "batch_mailer/item_create",
      formats: [:html],
      locals: { request: item }
    )

    # Render plain text version
    txt = render_to_string(
      template: "batch_mailer/item_create",
      formats: [:text],
      # layout: false,
      locals: { request: item }
    )

    builder.body_text(txt.to_str)
    builder.body_html(html.to_str)

    recipients.each do |user|
      if user != @user
        builder.add_recipient(:to, user.email, 'name' => user.name,
                                               'account-id' => user.id)
      end
    end
    builder.finalize
  end

  def item_complete(item, recipients = [])
    @item = item
    @user = item.user
    builder = batch_builder()
    builder.subject("Item #{@item.list.title.titleize} Completed")

    # Render html version
    html = render_to_string(
      template: "batch_mailer/item_complete",
      formats: [:html],
      locals: { request: item }
    )

    # Render plain text version
    txt = render_to_string(
      template: "batch_mailer/item_complete",
      formats: [:text],
      # layout: false,
      locals: { request: item }
    )

    builder.body_text(txt.to_str)
    builder.body_html(html.to_str)

    recipients.each do |user|
        builder.add_recipient(:to, user.email, 'name' => user.name,
                                               'account-id' => user.id)
    end
    builder.finalize
  end
end
