defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "Addition1" do
    assert Calc.eval("2 + 3") == 5
  end

  test "Addition2" do
    assert Calc.eval("2 * 3 + 5") == 11
  end

  test "Addition3" do
    assert Calc.eval("2 * 6 + 5") == 17
  end

  test "Subtraction1" do
    assert Calc.eval("5 - 7") == -2
  end

  test "Subtraction2" do
    assert Calc.eval("(3 / 1) - 23") == -20
  end

  test "Subtraction3" do
    assert Calc.eval("5 - 7") == -2
  end

  test "Division1" do
    assert Calc.eval("30 / 4") == 7
  end

  test "Division2" do
    assert Calc.eval("-14 / 2") == -7
  end

  test "Division3" do
    assert Calc.eval("(14 / 2) + (8 - 3)") == 12
  end

  test "Multiplication1" do
    assert Calc.eval("4 * 124") == 496
  end

  test "Multiplication2" do
    assert Calc.eval("( 4 * 3) / 6") == 2
  end

  test "Multiplication3" do
    assert Calc.eval("(1 * 3) * ( 6 + 2)") == 24
  end

  test "Multiplication4" do
    assert Calc.eval("(1 * 3) / 6") == 0
  end

  test "Parenthesis1" do
    assert Calc.eval("8 * 2 + ((11 + 11) + (9 - 11))") == 36
  end

  test "Parenthesis2" do
    assert Calc.eval("8 * (2 + (11 + (9 - 11)))") == 88
  end

end
