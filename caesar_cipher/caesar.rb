# puts "Enter plaintext and offset"
# user_input = gets


def caesar_cipher plaintext, offset=1
  alphabet = ('a'..'z').to_a
  plaintext.split('').map do |char|

    # if character is a capital: set flag, downcase, modify as normal
    char_was_capital = false
    if char != char.downcase
      char_was_capital = true
      char = char.downcase
    end

    # shift character in alphabet array
    char_index = alphabet.index char
    if char_index.nil?
      encoded_char = char
    else
      encoded_char = alphabet[(char_index + offset) % 26]
    end

    # restore character to capital as necessary
    if char_was_capital
      encoded_char.upcase
    else
      encoded_char
    end

  end.join
end