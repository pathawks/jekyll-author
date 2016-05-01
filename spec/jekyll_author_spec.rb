require 'spec_helper'

describe JekyllAuthor do
  let(:author1) do
    {
      'name' => 'Author 1',
      'email' => 'author1@example.com',
      'uri' => 'https://example.com/author1'
    }
  end
  let(:author2) do
    {
      'name' => 'Author 2',
      'email' => 'author2@example.com',
      'uri' => 'https://example.com/author2'
    }
  end
  let(:site) { make_site('authors' => [author2]) }

  def normalized_author(input = nil)
    ::JekyllAuthor::Author.new(site, input)
  end

  before do
    Jekyll.logger.log_level = :error
  end

  it 'builds' do
    expect(normalized_author(author1)).to eq author1
  end

  context 'when site.author is an author object' do
    let(:site) { make_site('author' => author1) }

    it 'returns site.author when passed nil' do
      expect(normalized_author(nil)).to eq author1
    end

    it 'returns an author object when one is passed' do
      expect(normalized_author(author2)).to eq author2
    end

    it 'returns a Hash with a name when passed a string' do
      author = normalized_author('Author 3')
      expect(author).to include('name' => 'Author 3')
    end
  end

  it 'can lookup an author in site.data.authors when passed a key' do
    expect(normalized_author('Author 2')).to eq author2
  end
end
