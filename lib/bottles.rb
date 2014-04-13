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

require 'forwardable'
class Verse
  extend Forwardable
  attr_reader :verse_number
  def initialize(number)
    @verse_number = VerseNumber.for(number)
  end

  def_delegators :verse_number, :act, :inventory, :pronoun, :container,
    :next_inventory, :next_container

  def to_s
    "#{inventory} #{container} #{liquid} #{location}, ".capitalize +
    "#{inventory} #{container} #{liquid}.\n" +
    "#{act}, " +
    "#{next_inventory} #{next_container} #{liquid} #{location}.\n"
  end

  def liquid
    "of beer"
  end

  def location
    "on the wall"
  end
end

class VerseNumber
  attr_reader :number
  def initialize(number)
    @number = number
  end

  def self.for(number, factory = VerseNumberFactory)
    factory.get_instance(number)
  end

  def next_verse_number
    number.pred
  end

  def inventory
    number
  end

  def pronoun
    "one"
  end

  def act
    "Take #{pronoun} down and pass it around"
  end

  def container
    "bottles"
  end

  def next_inventory
    succ.inventory
  end

  def next_container
    succ.container
  end

  def succ
    VerseNumber.for(next_verse_number)
  end
end

class VerseNumber0 < VerseNumber
  def act
    "Go to the store and buy some more"
  end

  def inventory
    "no more"
  end

  def next_verse_number
    99
  end
end

class VerseNumber1 < VerseNumber
  def container
    "bottle"
  end

  def pronoun
    "it"
  end
end

class VerseNumberFactory
  def self.get_instance(number)
    NumberedClassFactory.get_instance(VerseNumber, number)
  end
end

class NumberedClassFactory
  attr_reader :default_class, :number
  def initialize(default_class, number)
    @default_class = default_class
    @number = number
  end

  def self.get_instance(default_class, number)
    new(default_class, number).get_instance
  end

  def get_instance
    get_klass.new(number)
  end

  private

  def get_klass
   if Object.const_defined?(klass_string)
     Object.const_get(klass_string)
   else
     default_class
   end
  end

  def klass_string
   "#{default_class}#{number}"
  end
end
