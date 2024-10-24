# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/new', type: :view do
  include TestAttributes

  before(:each) do
    assign(:user, User.new)
    allow(view).to receive(:current_user).and_return(User.create!(valid_admin_attributes))
    assign(:projects, [Project.create!(valid_project_attributes), Project.create!(valid_project_attributes2)])
  end

  it 'renders new user form' do
    render
    assert_select 'form[action=?][method=?]', users_path, 'post' do
      assert_select 'input[name=?]', 'user[email]'
      assert_select 'input[name=?]', 'user[full_name]'
      assert_select 'input[type=?]', 'submit'
    end
  end

  it 'displays available projects' do
    render
    expect(rendered).to match(/#{valid_project_attributes[:projectName]}/)
    expect(rendered).to match(/#{valid_project_attributes2[:projectName]}/)
  end
end
