#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class Product < ActiveRecord::Base
  has_many :line_items
  # Products have many line_items, and line_items belongs to an order. We could
  # iterate and traverse, but by simply declaring that there is a relationship
  # between products and orders through the line_items relationship,
  # we can simplify our code:
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
#
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, length: {minimum: 10}

  def self.latest
    Product.order(:updated_at).last
  end

  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      # we have direct access to the errors object. This is the same place that
      # the validates() stores error messages. Errors can be associated with
      # individual attributes, but in this case we associate the error with the
      # base object.
      errors.add(:base, 'Line Items present')
      return false
    end
  end

end
