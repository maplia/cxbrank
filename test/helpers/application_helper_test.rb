require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "header_title" do
    assert_equal APP_INFO[:name], header_title(nil)
    assert_equal APP_INFO[:name], header_title(APP_INFO[:name])
    assert_equal "hogehoge - #{APP_INFO[:name]}", header_title('hogehoge')
    assert_equal "hogehoge piyopiyo - #{APP_INFO[:name]}", header_title('hogehoge', 'piyopiyo')
  end

  test "h1_title" do
    assert_equal APP_INFO[:name], h1_title(nil)
    assert_equal APP_INFO[:name], h1_title(APP_INFO[:name])
    assert_equal 'hogehoge', h1_title('hogehoge')
    assert_equal 'hogehoge <small>piyopiyo</small>', h1_title('hogehoge', 'piyopiyo')
  end

  test "sprintf_for_level" do
    assert_equal '-', sprintf_for_level(nil)
    assert_equal '0.0', sprintf_for_level(0)
    assert_equal '77.0', sprintf_for_level(77)
    assert_equal '77.7', sprintf_for_level(77.7)
  end

  test "sprintf_for_notes" do
    assert_equal '-', sprintf_for_notes(nil)
    assert_equal '0', sprintf_for_notes(0)
    assert_equal '34', sprintf_for_notes(34)
  end

  test "sprintf_for_rp" do
    assert_equal '-', sprintf_for_rp(nil)
    assert_equal '0.00', sprintf_for_rp(0)
    assert_equal '12.00', sprintf_for_rp(12)
    assert_equal '23.45', sprintf_for_rp(23.45)
  end

  test "sprintf_for_diff_rp" do
    assert_equal '-', sprintf_for_diff_rp(0)
    assert_equal '-12.00', sprintf_for_diff_rp(-12)
    assert_equal '+23.00', sprintf_for_diff_rp(+23)
    assert_equal '+23.45', sprintf_for_diff_rp(+23.45)
  end

  test "sprintf_for_rate" do
    assert_equal '-', sprintf_for_rate(nil)
    assert_equal '0%', sprintf_for_rate(0)
    assert_equal '98%', sprintf_for_rate(98)
    assert_equal '100%', sprintf_for_rate(100)
  end

  test "difficulty_id_to_sym" do
    assert_nil difficulty_id_to_sym(0)
    assert_equal :difficulty1, difficulty_id_to_sym(1)
    assert_equal :difficulty2, difficulty_id_to_sym(2)
    assert_equal :difficulty3, difficulty_id_to_sym(3)
    assert_nil difficulty_id_to_sym(4)
  end
end
