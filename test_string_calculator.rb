require 'minitest/autorun'
require_relative 'string_calculator'

class TestStringCalculator < Minitest::Test
  def test_empty_string
    assert_equal 0, StringCalculator.add("")
  end

  def test_single_number
    assert_equal 1, StringCalculator.add("1")
    assert_equal 5, StringCalculator.add("5")
  end

  def test_two_numbers
    assert_equal 3, StringCalculator.add("1,2")
    assert_equal 9, StringCalculator.add("4,5")
  end

  def test_multiple_numbers
    assert_equal 6, StringCalculator.add("1,2,3")
    assert_equal 15, StringCalculator.add("1,2,3,4,5")
  end

  def test_newline_delimiter
    assert_equal 6, StringCalculator.add("1\n2,3")
    assert_equal 10, StringCalculator.add("1\n2\n3,4")
  end

  def test_custom_delimiter
    assert_equal 3, StringCalculator.add("//;\n1;2")
    assert_equal 6, StringCalculator.add("//|\n1|2|3")
    assert_equal 6, StringCalculator.add("//***\n1***2***3")
    assert_equal 10, StringCalculator.add("//***\n1***2***3***4")
  end

  def test_negative_numbers
    exception = assert_raises(RuntimeError) { StringCalculator.add("1,-2,3,-4") }
    assert_equal "negatives not allowed: -2, -4", exception.message
  end

  def test_ignore_large_numbers
    assert_equal 2, StringCalculator.add("2,1001")
    assert_equal 1002, StringCalculator.add("2,1000")
  end

  def test_multi_char_delimiter
    assert_equal 6, StringCalculator.add("//[***]\n1***2***3")
    assert_equal 10, StringCalculator.add("//[---]\n1---2---3---4")
  end

  def test_multiple_delimiters
    assert_equal 6, StringCalculator.add("//[*][%]\n1*2%3")
    assert_equal 10, StringCalculator.add("//[**][%%]\n1**2%%3**4")
  end

  def test_multiple_long_delimiters
    assert_equal 6, StringCalculator.add("//[***][%%]\n1***2%%3")
    assert_equal 10, StringCalculator.add("//[--][+++]\n1--2+++3--4")
  end
end
