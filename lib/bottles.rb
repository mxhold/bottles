class Bottles
  def sing
    verses(99, 0)
  end

  def verses(upper_bound, lower_bound)
    upper_bound.downto(lower_bound).map {|n| verse(n) + "\n"}.join
  end

  def verse(number)
    "#{current_inventory(number)} #{current_container(number)} #{liquid} #{location}, ".capitalize +
    "#{current_inventory(number)} #{current_container(number)} #{liquid}.\n" +
    "#{action(number)}, " +
    "#{next_inventory(number)} #{next_container(number)} #{liquid} #{location}.\n"
  end

  def liquid
    'of beer'
  end

  def location
    'on the wall'
  end

  def current_inventory(number)
    case number
    when 0
      'no more'
    else
      number
    end
  end

  def next_inventory(number)
    case number
    when 0
      99
    when 1
      'no more'
    else
      number - 1
    end
  end

  def current_container(number)
    case number
    when 1
      'bottle'
    else
      'bottles'
    end
  end

  def next_container(number)
    case number
    when 2
      'bottle'
    else
      'bottles'
    end
  end

  def action(number)
    case number
    when 0
      "Go to the store and buy some more"
    else
      "Take #{pronoun(number)} down and pass it around"
    end
  end

  def pronoun(number)
    case number
    when 1
      'it'
    else
      'one'
    end
  end
end
