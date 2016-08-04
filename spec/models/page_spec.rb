require 'rails_helper'

describe Page do
  subject { page }
  it { should be_valid }

  let!(:page){FactoryGirl.create :page}

  describe 'validates associations' do
    it { should have_many(:page_contents) }
    it { should have_many(:contents) }
  end

  describe 'validates url' do
    it { should validate_presence_of(:url) }

    context 'url format' do
      context 'valid' do
        it 'should valid when url has protocol http or https' do
          page.url = 'https://example.com'
          expect { page.save! }.not_to raise_error
          page.url = 'http://example.com'
          expect { page.save! }.not_to raise_error
        end
        it 'should valid when url has sub-domain' do
          page.url = 'www.example.com'
          expect { page.save! }.not_to raise_error
          page.url = 'admin.example.com'
          expect { page.save! }.not_to raise_error
        end
        it 'should valid when url has string query' do
          page.url = 'www.example.com?q=abcd'
          expect { page.save! }.not_to raise_error
          page.url = 'admin.example.com/abcd.html'
          expect { page.save! }.not_to raise_error
        end
        it 'should add http protocol automatically' do
          page.url = 'www.example.com'
          page.valid?
          expect(page.url).to eq 'http://www.example.com'
        end
      end
      context 'invalid' do
        it 'should invalid when url is none http protocol' do
          page.url = 'fft://www.example.com'
          expect { page.save! }.to raise_error
        end
        it 'should invalid when url is not url path' do
          page.url = 'fft://www.example'
          expect { page.save! }.to raise_error
        end
      end
    end
  end
end