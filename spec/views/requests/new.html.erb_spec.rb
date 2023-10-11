require 'rails_helper'

RSpec.describe 'requests/new' do
  before do
    assign(:request, Request.new(
                       title: 'MyString',
                       description: 'MyText',
                       user: nil
                     ))
  end

  it 'renders new request form' do
    render

    assert_select 'form[action=?][method=?]', requests_path, 'post' do
      assert_select 'input[name=?]', 'request[title]'

      assert_select 'textarea[name=?]', 'request[description]'

      assert_select 'input[name=?]', 'request[user_id]'
    end
  end
end
