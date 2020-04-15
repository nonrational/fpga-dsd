#!/usr/bin/env ruby

class Blinky
  @alpha = {
    'A' => '10111',
    'B' => '111010101',
    'C' => '11101011101',
    'D' => '1110101',
    'E' => '1',
    'F' => '101011101',
    'G' => '111011101',
    'H' => '1010101',
    'I' => '101',
    'J' => '1011101110111',
    'K' => '111010111',
    'L' => '101110101',
    'M' => '1110111',
    'N' => '11101',
    'O' => '11101110111',
    'P' => '10111011101',
    'Q' => '1110111010111',
    'R' => '1011101',
    'S' => '10101',
    'T' => '111',
    'U' => '1010111',
    'V' => '101010111',
    'W' => '101110111',
    'X' => '11101010111',
    'Y' => '1110101110111',
    'Z' => '11101110101',
    ' ' => '00000'
  }

  def self.encode(msg)
    message = msg.split('') + ['']

    message.map { |c| @alpha[c] }  # map chars to morse
           .join('000_')           # join with pauses
           .delete_suffix('_')     # join leaves us with an extra _
           .reverse                # read LSB -> MSB
  end
end

stream = Blinky.encode('A B C D E')
width = stream.gsub(/_/, '').length

puts "#{width}'b#{stream}"
