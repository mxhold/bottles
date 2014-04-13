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
  attr_reader :verse_number
  def initialize(number)
    @verse_number = VerseNumber.for(number)
  end

  def to_s
    "#{current_inventory} #{current_container} #{liquid} #{location}, ".capitalize +
    "#{current_inventory} #{current_container} of beer.\n" +
    "#{act}, " +
    "#{next_inventory} #{next_container} #{liquid} #{location}.\n"
  end

  def liquid
    "of beer"
  end

  def location
    "on the wall"
  end

  def act
    verse_number.act
  end

  def current_inventory
    verse_number.current_inventory
  end

  def next_inventory
    verse_number.next_inventory
  end

  def pronoun
    verse_number.pronoun
  end

  def current_container
    verse_number.current_container
  end

  def next_container
    verse_number.next_container
  end
end

class VerseNumber
  attr_reader :number, :verse_number
  def initialize(number)
    @number = number
  end

  def self.for(number)
    verse_class = "VerseNumber#{number}"
    if Object.const_defined?(verse_class)
      Object.const_get(verse_class)
    else
      VerseNumber
    end.new(number)
  end

  def act
    "Take #{pronoun} down and pass it around"
  end

  def current_inventory
    number
  end

  def next_inventory
    number - 1
  end

  def pronoun
    "one"
  end

  def current_container
    "bottles"
  end

  def next_container
    "bottles"
  end
end

class VerseNumber0 < VerseNumber
  def act
    "Go to the store and buy some more"
  end

  def current_inventory
    "no more"
  end

  def next_inventory
    99
  end
end

class VerseNumber1 < VerseNumber
  def current_container
    "bottle"
  end

  def pronoun
    "it"
  end

  def next_inventory
    "no more"
  end
end

class VerseNumber2 < VerseNumber
  def next_container
    "bottle"
  end
end
