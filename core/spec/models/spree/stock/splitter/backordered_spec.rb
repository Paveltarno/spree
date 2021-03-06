require 'spec_helper'

module Spree
  module Stock
    module Splitter
      describe Backordered, :type => :model do
        let(:variant) { build(:variant) }
        let(:line_item) { build(:line_item, variant: variant) }
        let(:packer) { build(:stock_packer) }

        subject { Backordered.new(packer) }

        it 'splits packages by status' do
          package = Package.new(packer.stock_location, packer.order)
          package.add line_item, 4, :on_hand
          package.add line_item, 5, :backordered

          packages = subject.split([package])
          expect(packages.count).to eq 2
          expect(packages.first.quantity).to eq 4
          expect(packages.first.on_hand.count).to eq 1
          expect(packages.first.backordered.count).to eq 0

          expect(packages[1].quantity).to eq 5
        end
      end
    end
  end
end
