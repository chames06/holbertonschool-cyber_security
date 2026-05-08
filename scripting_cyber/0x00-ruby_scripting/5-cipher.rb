#!/usr/bin/env ruby

# Class implementing Caesar Cipher encryption and decryption
class CaesarCipher
  # Initializes the cipher with a shift value
  def initialize(shift)
    @shift = shift
  end

  # Encrypts a plaintext message
  def encrypt(message)
    cipher(message, @shift)
  end

  # Decrypts a ciphertext message
  def decrypt(message)
    cipher(message, -@shift)
  end

  private

  # Core method to apply Caesar cipher
  # Only callable within the instance
  def cipher(message, shift)
    result = ''

    message.each_char do |char|
      if char >= 'a' && char <= 'z'
        base = 'a'.ord
        offset = (char.ord - base + shift) % 26
        result << (base + offset).chr
      elsif char >= 'A' && char <= 'Z'
        base = 'A'.ord
        offset = (char.ord - base + shift) % 26
        result << (base + offset).chr
      else
        result << char
      end
    end

    result
  end
end
