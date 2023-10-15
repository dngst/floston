require 'rails_helper'

RSpec.describe CommentsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users/1/requests/1/comments').to route_to('comments#index', user_id: '1', request_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/users/1/requests/1/comments/new').to route_to('comments#new', user_id: '1', request_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/users/1/requests/1/comments/1').to route_to('comments#show', user_id: '1', request_id: '1', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/users/1/requests/1/comments/1/edit').to route_to('comments#edit', user_id: '1', request_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/users/1/requests/1/comments').to route_to('comments#create', user_id: '1', request_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/users/1/requests/1/comments/1').to route_to('comments#update', user_id: '1', request_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/users/1/requests/1/comments/1').to route_to('comments#update', user_id: '1', request_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/users/1/requests/1/comments/1').to route_to('comments#destroy', user_id: '1', request_id: '1', id: '1')
    end
  end
end
