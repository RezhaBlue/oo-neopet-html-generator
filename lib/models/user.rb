class User
  attr_reader :name
  attr_accessor :neopets, :neopoints, :items

  PET_NAMES = ["Angel", "Baby", "Bailey", "Bandit", "Bella", "Buddy", "Charlie", "Chloe", "Coco", "Daisy", "Lily", "Lucy", "Maggie", "Max", "Molly", "Oliver", "Rocky", "Shadow", "Sophie", "Sunny", "Tiger"]

  def initialize(name)
    @name = name
    @neopets = []
    @items = []
    @neopoints = 2500
  end

  def select_pet_name
    current_pets = self.neopets.collect {|pet| pet.name }
    name = PET_NAMES.sample
    while current_pets.include?(name)
      name = PET_NAMES.sample
    end
    name
  end

  def buy_neopet
    if self.neopoints >= 250
      self.neopets << Neopet.new(select_pet_name)
      self.neopoints -= 250
    else
      "Sorry, you do not have enough Neopoints."
    end
  end

  def buy_item
    if self.neopoints >= 150
      self.items << Item.new
      self.neopoints -= 150
    else
      "Sorry, you do not have enough Neopoints."
    end
  end

  def sell_neopet_by_name(name)
    found = find_neopet_by_name(name)
    if found
      self.neopets.delete(found)
      self.neopoints += 200
      "You have sold #{name}. You now have #{self.neopoints} neopoints."
    else
      not_found_message(name)
    end
  end

  def feed_neopet_by_name(name)
    found = find_neopet_by_name(name)
    if found
      if found.happiness < 10
        feed_nonestatic_neopet(found)
      else
        "Sorry, feeding was unsuccessful as #{found.name} is already #{found.mood}."
      end
    else
      not_found_message(name)
    end
  end

  def feed_nonestatic_neopet(neopet)
    if neopet.happiness < 9
      neopet.happiness += 2
    elsif neopet.happiness < 10
      neopet.happiness += 1
    end
    "After feeding, #{neopet.name} is #{neopet.mood}."
  end

  def not_found_message(name)
    "Sorry, there are no pets named #{name}."
  end

  def find_neopet_by_name(name)
    self.neopets.each do |pet|
      if pet.name == name
        return pet
      end
    end
    nil
  end

  def make_file_name_for_index_page
    self.name.gsub(" ", "-").downcase
  end

  def make_index_page
    File.open("views/users/#{make_file_name_for_index_page}.html", 'w') do |file| 
      file.write(get_html)
    end
  end

  def get_html
    html = "<!DOCTYPE html>\n\n<html>\n<head>\n<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css\">\n<link rel=\"stylesheet\" href=\"http://getbootstrap.com/examples/jumbotron-narrow/jumbotron-narrow.css\">\n<title>#{self.name}</title>\n</head>\n<body>\n<div class=\"container\">\n<div class=\"jumbotron\">\n<h1>#{self.name}</h1>\n<h3><strong>Neopoints:</strong> #{self.neopoints}</h3>\n</div>\n<div class=\"row marketing\">\n"
    add_neopets_to_html(html)
    add_items_to_html(html)
    html << "</div>\n</body>\n</html>"
  end

  def add_neopets_to_html(html)
    html << "<div class=\"col-lg-6\">\n<h3>Neopets</h3><ul>\n"
    self.neopets.each do |pet|
      html << "<li><img src=\"..\/..\/public/img/neopets/#{pet.species}.jpg\"></li>\n<ul>\n"
      methods = [:name, :mood, :species, :strength, :defence, :movement]
      methods.each do |method|
        html << "<li><strong>#{method.to_s.capitalize}:<\/strong> #{pet.send(method)}<\/li>"
      end
      html << "</ul>"
    end
    html << "</ul>\n</ul>\n</div>\n"
  end

  def add_items_to_html(html)
    html << "<div class=\"col-lg-6\">\n<h3>Items</h3>\n"
    html << "<ul>\n"
    self.items.each do |item|
      html << "<li><img src=\"..\/..\/public/img/items/#{item.type}.jpg\"></li>\n"
      html << "<ul><li><strong>Type:</strong> #{item.formatted_type}</li></ul>\n"
    end
    html << "</ul>\n</div>\n</div>\n"
  end

end