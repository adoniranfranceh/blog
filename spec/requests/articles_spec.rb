require 'rails_helper'

RSpec.describe 'Articles' do
  before(:each) { Article.create(title: 'art 1', content: 'conteudo do art 1') }

  context 'GET /api/v1/articles' do
    it 'responds with status Ok' do
      get '/api/v1/articles.json'

      expect(response).to have_http_status(:ok)
    end

    it 'responds with correct persisted article json' do
      get '/api/v1/articles.json'

      expect(response.body).to include('art 1')
      expect(response.body).to include('conteudo do art 1')
    end
  end
end
