module ApplicationHelper
  def word_form(number)
    last_digit = number % 10
    last_two_digits = number % 100

    if (11..19).include?(last_two_digits)
      'товаров'
    elsif last_digit == 1
      'товар'
    elsif (2..4).include?(last_digit)
      'товара'
    else
      'товаров'
    end
  end
end
