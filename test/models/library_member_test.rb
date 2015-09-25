require 'test_helper'

class LibraryMembersTest < ActiveSupport::TestCase

  def setup
    @library_member = LibraryMember.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @library_member.valid?
  end

  test "name should be present" do
    @library_member.name = "     "
    assert_not @library_member.valid?
  end

  test "email should be present" do
    @library_member.email = "     "
    assert_not @library_member.valid?
  end

  test "name should not be too long" do
    @library_member.name = "a" * 51
    assert_not @library_member.valid?
  end

  test "email should not be too long" do
    @library_member.email = "a" * 244 + "@example.com"
    assert_not @library_member.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @library_member.email = valid_address
      assert @library_member.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @library_member.email = invalid_address
      assert_not @library_member.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @library_member.dup
    duplicate_user.email = @library_member.email.upcase
    @library_member.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @library_member.password = @library_member.password_confirmation = " " * 6
    assert_not @library_member.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @library_member.email = mixed_case_email
    @library_member.save
    assert_equal mixed_case_email.downcase, @library_member.reload.email
  end

  test "password should have a minimum length" do
    @library_member.password = @library_member.password_confirmation = "a" * 5
    assert_not @library_member.valid?
  end

end