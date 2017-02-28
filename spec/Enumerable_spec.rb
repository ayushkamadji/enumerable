require 'Enumerable'
require 'spec_helper'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5] }

  describe "#my_each_with_index" do

     context "with no blocks" do
       it "returns an Enumerator" do
         expect(arr.my_each_with_index).to be_instance_of(Enumerator)
       end
     end

     context "with block" do
       it "itterates through the elements with index" do
         result = []
         arr.my_each_with_index { |e, i| result << [e, i] }
         expect(result).to eql([[1,0], [2,1], [3,2], [4,3], [5,4]]) 
       end
     end
  end

  describe "#my_each" do
    context "with no blocks" do
      it "returns an Enumerator" do
        expect(arr.my_each).to be_instance_of(Enumerator)
      end
    end

    context "with block" do
      it "itterates through the elements" do
        result = []
        arr.my_each { |e| result << e }
        expect(result).to eql([1,2,3,4,5])
      end
    end
  end

  describe "#my_select" do
    context "with no blocks" do
      it "returns an Enumerator" do
        expect(arr.my_select).to be_instance_of(Enumerator)
      end
    end

    context "with block" do
      it "returns array with selected elements" do
        expect(arr.my_select { |e| e < 4 }).to eql([1,2,3])
      end
    end
  end

  describe "#my_all?" do
    context "with no blocks" do
      it "returns true" do
        expect(arr.my_all?).to eql(true)
      end
    end

    context "with block" do
      context "and all elements meet criteria" do
        it "returns true" do
          expect(arr.my_all? { |e| e < 6 }).to eql(true)
        end
      end

      context "and not all elements meet criteria" do
        it "returns false" do
          expect(arr.my_all? { |e| e < 2 }).to eql(false)
        end
      end
    end
  end

  describe "#my_any?" do
    context "with no blocks" do
      it "returns true" do
        expect(arr.my_any?).to eql(true)
      end
    end

    context "with block" do
      context "and some elements fulfill criteria" do
        it "returns true" do
          expect(arr.my_any? { |e| e == 1 }).to eql(true)
        end
      end

      context "and no element fulfills criteria" do
        it "returns false" do
          expect(arr.my_any? { |e| e < 0 }).to eql(false)
        end
      end
    end
  end

  describe "#my_none?" do
    context "with no block" do
      it "returns true" do
        expect(arr.my_none?).to eql(true)
      end
    end

    context "with block" do
      context "and no element fulfill criteria" do
        it "returns true" do
          expect(arr.my_none? { |e| e == 0 }).to eql(true)
        end
      end

      context "and some elements fulfill criteria" do
        it "returns false" do
          expect(arr.my_none? { |e| e > 0 }).to eql(false)
        end
      end
    end
  end
end
