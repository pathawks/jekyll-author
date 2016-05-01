# Encoding: utf-8

module JekyllAuthor
  class Author < Hash
    attr_reader 'name', 'uri', 'email'
    # Returns a normalized author object for a given author
    #
    # site - The Site object.
    # author - An author object or an author name string
    def initialize(site, author)
      @site = site
      @author = author

      lookup_author

      if @author.is_a? Hash
        self['name'] = @author['name']
        self['email'] = @author['email']
        self['uri'] = @author['uri']
      elsif @author.is_a? String
        self['name'] = @author
      end
    end

    private

    def default
      @site.config['author']
    end

    def lookup_author
      @author ||= default
      if @author.is_a?(String) && @site.config['authors'].is_a?(Array)
        @site.config['authors'].each do |a|
          if a['name'] == @author
            @author = a
            break
          end
        end
      end
    end
  end
end
