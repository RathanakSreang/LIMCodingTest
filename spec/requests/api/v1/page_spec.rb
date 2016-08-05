require 'rails_helper'

describe 'Page API' do
  let!(:page){FactoryGirl.create :page}

  describe 'Post #fetch' do
    it 'should return errors when url is not valid' do
      post '/api/v1/pages/fetch', url: 'not_url'
      expect_json('errors', regex("is not an url") )
    end

    it 'should return errors when cannot save url page to db' do
      allow_any_instance_of(Page).to receive(:fetch_contents).and_return([])
      allow_any_instance_of(Page).to receive(:save!).and_return(false)
      post '/api/v1/pages/fetch', url: 'working.com'
      expect_json('errors', regex("Cannot fetch page") )
    end

    it 'should return page information' do
      allow_any_instance_of(Page).to receive(:fetch_contents).and_return([])
      allow_any_instance_of(Page).to receive(:save!).and_return(true)
      post '/api/v1/pages/fetch', url: 'working.com'
      expect_json('page', {id: nil, url: 'http://working.com', a_tags: [], h_tags: []} )
    end
  end

  describe 'Get #list' do
    it 'should return pages array with page content info' do
      get '/api/v1/pages/list'
      expect_json_types('pages.*', id: :int, url: :string, a_tags: :array, h_tags: :array)
    end
    it 'should return [] if no page in db' do
      Page.destroy_all
      get '/api/v1/pages/list'
      expect_json('pages', [])
    end
  end
end