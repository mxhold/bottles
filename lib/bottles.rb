class Bottles
  def sing
    verses(99, 0)
  end

  def verses(upper_bound, lower_bound)
    upper_bound.downto(lower_bound).map {|n| verse(n) + "\n"}.join
  end

  def verse(number)
    Verse.new(number).to_s
  end
end

class Verse
  attr_reader :number
  def initialize(number)
    @number = number.to_beer_bottle
  end

  def to_s
    "#{number} #{number.location}, ".capitalize +
    "#{number}.\n" +
    "#{number.action}, " +
    "#{number.next} #{number.location}.\n"
  end
end

require 'delegate'

class Fixnum
  def to_bottle
    case self
    when 0
      BottleFixnum0.new(self)
    when 1
      BottleFixnum1.new(self)
    else
      BottleFixnum.new(self)
    end
  end

  def to_beer_bottle
    case self
    when 0
      BeerSongFixnum0.new(self.to_bottle)
    when 1
      BeerSongFixnum1.new(self.to_bottle)
    else
      BeerSongFixnum.new(self.to_bottle)
    end
  end
end

class BeerSongFixnum < SimpleDelegator
  def number
    __getobj__
  end

  def to_s
    __getobj__.to_s + " " + liquid
  end

  def liquid
    'of beer'
  end

  def location
    'on the wall'
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def next
    (__getobj__.pred % 100).to_beer_bottle
  end

  private

  def pronoun
    'one'
  end
end

class BeerSongFixnum1 < BeerSongFixnum
  private

  def pronoun
    'it'
  end
end

class BeerSongFixnum0 < BeerSongFixnum
  def action
    "Go to the store and buy some more"
  end
end

class BottleFixnum < SimpleDelegator
  alias_method :number, :__getobj__

  def to_s
    "#{name} #{unit}"
  end

  def name
    __getobj__
  end

  def unit
    'bottles'
  end

  def pred
    number.pred.to_bottle
  end
end

class BottleFixnum1 < BottleFixnum
  def unit
    'bottle'
  end
end

class BottleFixnum0 < BottleFixnum
  def name
    'no more'
  end
end
