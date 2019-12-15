require 'rails_helper'

RSpec.describe Variant, type: :model do
  it 'has a valid factory' do
    # Check that the factory we created is valid
    expect(build(:variant)).to be_valid
  end

  let(:attributes) do
    # {
    #   name: 'Kodak DSLR2',
    #   description: 'Very good super machine'
    # }

      attrs = attributes_for(:variant)
  end

let(:variant) { create(:variant, **attributes) }
  # let(:product) { create(:product) }

  describe 'model validations' do
    # check that the name field received the right values
    it { expect(variant).to allow_value(attributes[:name]).for(:name) }
    # ensure that the title field is never empty
    it { expect(variant).to validate_presence_of(:name) }
    # ensure that the title is unique for each todo list
    it { expect(variant).to validate_uniqueness_of(:name)}

    it { expect(variant).to allow_value(attributes[:product]).for(:product) }

    end

    describe 'model associations' do
   # ensure a todo list has many items
   it { expect(variant).to belong_to(:product) }
   # it { expect(product).to have_many(:items) }
 end
end
