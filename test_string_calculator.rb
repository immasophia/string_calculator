require 'rspec'
require_relative 'string_calculator'

RSpec.describe StringCalculator do
  describe '.add' do
    it 'returns 0 for an empty string' do
      expect(StringCalculator.add("")).to eq(0)
    end

    it 'returns the number for a single number' do
      expect(StringCalculator.add("1")).to eq(1)
      expect(StringCalculator.add("5")).to eq(5)
    end

    it 'returns the sum of two numbers' do
      expect(StringCalculator.add("1,2")).to eq(3)
      expect(StringCalculator.add("4,5")).to eq(9)
    end

    it 'returns the sum of multiple numbers' do
      expect(StringCalculator.add("1,2,3")).to eq(6)
      expect(StringCalculator.add("1,2,3,4,5")).to eq(15)
    end

    it 'handles newlines as delimiters' do
      expect(StringCalculator.add("1\n2,3")).to eq(6)
      expect(StringCalculator.add("1\n2\n3,4")).to eq(10)
    end

    it 'supports custom delimiters' do
      expect(StringCalculator.add("//;\n1;2")).to eq(3)
      expect(StringCalculator.add("//|\n1|2|3")).to eq(6)
      expect(StringCalculator.add("//***\n1***2***3")).to eq(6)
      expect(StringCalculator.add("//***\n1***2***3***4")).to eq(10)
    end

    it 'raises an error for negative numbers' do
      expect { StringCalculator.add("1,-2,3,-4") }.to raise_error(RuntimeError, "negatives not allowed: -2, -4")
    end

    it 'ignores numbers larger than 1000' do
      expect(StringCalculator.add("2,1001")).to eq(2)
      expect(StringCalculator.add("2,1000")).to eq(1002)
    end

    it 'supports multi-character delimiters' do
      expect(StringCalculator.add("//[***]\n1***2***3")).to eq(6)
      expect(StringCalculator.add("//[---]\n1---2---3---4")).to eq(10)
    end

    it 'supports multiple delimiters' do
      expect(StringCalculator.add("//[*][%]\n1*2%3")).to eq(6)
      expect(StringCalculator.add("//[**][%%]\n1**2%%3**4")).to eq(10)
    end

    it 'supports multiple long delimiters' do
      expect(StringCalculator.add("//[***][%%]\n1***2%%3")).to eq(6)
      expect(StringCalculator.add("//[--][+++]\n1--2+++3--4")).to eq(10)
    end
  end
end
