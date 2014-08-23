require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["karloslopez@me.com"], mail.to
    assert_equal ["carloslopez12@gmail.com"], mail.from
    # assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
    # This test fail because the order_id is not saved in line_items
    # (which happens when the order is created via Order controller -add_line_items_from_cart-)
    # which is necessary in order to render line_items:
    #
    # LineItem Load (0.1ms) [0m  SELECT "line_items".* FROM "line_items"
    # WHERE "line_items"."order_id" = ?  [["order_id", 980190962]]
    # Rendered collection (0.0ms)
    # Rendered order_notifier/shipped.html.erb (11.6ms)
    # TODO: figure out how to test it.
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["karloslopez@me.com"], mail.to
    assert_equal ["carloslopez12@gmail.com"], mail.from
    # assert_match /<td>1&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>/,
      mail.body.encoded
  end

end
