# Encoding: utf-8

module JekyllAuthor
  class Author < Hash
    attr_reader :name, :uri, :email
    # Returns a normalized author object for a given author
    #
    # site - The Site object.
    # author - An author object or an author name string
    def initialize(site, author)
      @site = site
      @author = author

      lookup_author
      hash_author
    end

    private

    def default
      @site.config['author']
    end

    def lookup_author
      @author ||= default
      if @author.is_a?(String) && @site.config['authors'].is_a?(Array)
        author = @site.config['authors'].find { |a| a[:name] == @author }
        @author = author unless author.nil?
      end
    end

    def hash_author
      if @author.is_a? Hash
        self[:name] = @author[:name]
        self[:email] = @author[:email]
        self[:uri] = @author[:uri]
      elsif @author.is_a? String
        self[:name] = @author
      end
    end
  end
end
