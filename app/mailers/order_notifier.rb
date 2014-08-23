class OrderNotifier < ActionMailer::Base
  default from: "Carlos Lopez <carloslopez12@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received order
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shepped.subject
  #
  def shipped order
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
