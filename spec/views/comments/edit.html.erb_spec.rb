require 'rails_helper'

RSpec.describe 'comments/edit' do
  let(:comment) do
    Comment.create!(
      body: 'MyText',
      request: nil,
      user: nil
    )
  end

  before do
    assign(:comment, comment)
  end

  it 'renders the edit comment form' do
    render

    assert_select 'form[action=?][method=?]', comment_path(comment), 'post' do
      assert_select 'textarea[name=?]', 'comment[body]'

      assert_select 'input[name=?]', 'comment[request_id]'

      assert_select 'input[name=?]', 'comment[user_id]'
    end
  end
end
