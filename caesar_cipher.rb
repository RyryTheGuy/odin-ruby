# Caesar Cipher Mini-Project
# Learned about Duck Typing: instead of finding what the object's class is, it's better to 
#                            find what methods the object responds to (#respond_to?())

# Caesar Cipher function will accept a string and shift amount each character will shift by
def caesar_cipher(string, shift)
  # Break up the string into a character array
  char_array = string.split("")
  # Convert the characters into their char codes
  char_array.map! do |char|
    # Only convert alphabetic characters to their char codes, otherwise return the character
    if /^[A-Z]+$/i.match?(char)
      char.ord
    else
      char
    end
  end
  # Shift the characters the specified shift amount
  char_array.map! { |code| code.respond_to?(:abs) ? wrap_char_code(code, shift) : code }
  # Convert the character codes back into characters and join the characters back together
  char_array.map! { |code| code.respond_to?(:abs) ? code.chr : code }.join
end

# Wraps the char code so any number past z will return to a or Z to A
def wrap_char_code(code, shift)
  # Reduce the shift to only one wrap
  shift %= 26
  # Uppercase letters
  if (65..90).include?(code)
    # If the shift causes the code to wrap, then return the wrapped char code
    # Otherwise just return the shifted code
    return (code + shift) % 90 < 64 ? 64 + ((code + shift) % 90) : code + shift
    # Lowercase letters
  elsif (97..122).include?(code)
    return (code + shift) % 122 < 96 ? 96 + ((code + shift) % 122) : code + shift
  end
end


p caesar_cipher("Hello, World!", -29)