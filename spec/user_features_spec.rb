require 'spec_helper.rb'
require 'user.rb'

Capybara.default_driver = :selenium

Capybara.app_host = "http://pai-test.herokuapp.com/"

RSpec.describe "User", type: :feature do
  before(:all) { @user = User.new }

  describe "signup process" do
    it "display signup page" do
      visit "/users/sign_up"
      expect(page).to have_selector(:link_or_button, "Start Analyzing »")
    end

    describe "with valid information" do
      
      before { @user.register }
      
      it "redirect to welcome page with message" do
        expect(page).to have_css('div.alert-success')
        expect(page).to have_link("Logout", href: "/users/sign_out")
        expect(page).to_not have_link("Log in", href: "users/sign_in")
      end
    end

    describe "with invalid information" do
      before do 
        @user.register
        @user.register
      end
      
      it "display error message" do
        expect(page).to have_css('div.alert-danger')
      end
    end
  end

  describe "login" do
    it "display login page" do
      visit "/users/sign_in"
      expect(page).to have_selector(:link_or_button, 'Sign in')
    end

    describe "with correct information" do
      before { @user.signin }

      it "signs me in and redirect to profile page" do
        expect(page).to have_css('.alert, .alert-success')
        expect(page).to have_link("Logout", href: "/users/sign_out")
      end
    end

    describe "with invalid information" do
      before { visit "/users/sign_in" } 
      it "display error message" do
        click_button 'Sign in'
        expect(page).to have_css('.alert, .alert-danger')
      end
    end
  end

  describe "signout process" do
    before { @user.signin }
    
    it "signout user" do
      sleep 1
      click_link("Logout")
      expect(page).to_not have_link("Logout", href: "/users/sign_out")
      expect(page).to have_link("Log in", href: "/users/sign_in")
    end
  end
end