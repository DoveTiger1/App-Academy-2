require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  let(:dessert) {Dessert.new('brownie', 5, chef)}

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq ('brownie')
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq (5)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect{Dessert.new('brownie', 'ten', chef)}.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient('cream')
      expect(dessert.ingredients).to include('cream')
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do 
      ingredients = %w[cream chocolate milk salt]
      ingredients.each { |ing| dessert.add_ingredient(ing)}

      expect(dessert.ingredients).to eq(ingredients)
      dessert.mix!
      expect(dessert.ingredients).not_to eq(ingredients)
      expect(dessert.ingredients.sort).to eq (ingredients.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(3)
      expect(dessert.quantity).to be(2)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect {dessert.eat(8)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Chef the Great Baker")
      expect(dessert.serve).to eq("Chef Chef the Great Baker has made 5 brownies!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
