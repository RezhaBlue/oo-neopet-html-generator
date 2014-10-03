describe "User" do
  let(:mandy) { User.new("Mandy Moore") }

  describe "#name" do
    it "is instantiated with a name" do
      expect { mandy }.to_not raise_error
    end
    it "knows its name" do
      expect(mandy.name).to eq("Mandy Moore")
    end
    it "cannot change its name" do
      expect { mandy.name=("Jessica Simpson") }.to raise_error
    end
  end

  describe "#neopoints" do
    it "is instantiated with a 2,500 neopoints" do
      expect(mandy.neopoints).to eq(2500)
    end
    it "can change its value" do
      mandy.neopoints = 3000
      expect(mandy.neopoints).to eq(3000)
    end
  end

  describe "#items" do
    it "starts as an empty array" do
      expect(mandy.items).to eq([])
    end
    it "allows items to be added and removed" do
      mandy.items << first_item = Item.new
      mandy.items << second_item = Item.new
      expect(mandy.items.length).to eq(2)
      expect(mandy.items).to include(first_item)
      expect(mandy.items).to include(second_item)
      mandy.items.shift
      expect(mandy.items.length).to eq(1)
    end
  end

  describe "#neopets" do
    it "starts as an empty array" do
      expect(mandy.items).to eq([])
    end
    it "allows pets to be added and removed" do
      mandy.neopets << princess = Neopet.new("Princess")
      mandy.neopets << sir = Neopet.new("Sir Whiskers")
      expect(mandy.neopets.length).to eq(2)
      expect(mandy.neopets).to include(princess)
      expect(mandy.neopets).to include(sir)
      mandy.neopets.shift
      expect(mandy.neopets.length).to eq(1)
    end
  end

end