module GildedRose
  class Rose
    attr_reader :sell_in, :quality

    def initialize(sell_in, quality)
      @sell_in, @quality = sell_in, quality
    end

    def age
      @quality -= 1

      if sell_in <= 0
        @quality -= 1
      end

      if @quality < 0
        @quality = 0
      end

      @sell_in -= 1
    end
  end

  class Brie < Rose
    def age
      @quality += 1

      if sell_in <= 0
        @quality += 1
      end

      if quality > 50
        @quality = 50
      end

      @sell_in -= 1
    end

  end

  class Backstage < Rose
    def age
      case
        when sell_in > 10
          @quality += 1
        when sell_in <= 10 && sell_in >= 6
          @quality += 2
        when sell_in <= 5 && sell_in > 0
          @quality += 3
        else
          @quality = 0
      end

      if quality > 50
        @quality = 50
      end

      @sell_in -= 1
    end

  end

  class Sulfuras < Rose
    def age
    end
  end

  class Conjured < Rose
    def age
      @quality -= 2

      if sell_in <= 0
        @quality -= 2
      end

      if quality < 0
        @quality = 0
      end

      @sell_in -= 1
    end
  end

  CLASSES = {'Aged Brie' => Brie,
             'Backstage passes to a TAFKAL80ETC concert' => Backstage,
             'Sulfuras, Hand of Ragnaros' => Sulfuras,
             'Conjured Mana Cake' => Conjured}

  def self.for(item)
    klass = CLASSES[item.name] || Rose
    rose = klass.new(item.sell_in, item.quality)
    rose.age
    item.sell_in, item.quality = rose.sell_in, rose.quality
  end
end

def update_quality(items)
  items.each do |i|
    GildedRose.for(i)
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

