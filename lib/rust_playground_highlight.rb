module Jekyll
  module Tags
    class RustPlaygroundHighlight < HighlightBlock
      attr_accessor :raw, :gist_id

      def add_code_tag(code)
        super.sub(/\n*<\/pre>/,"</pre><a href='#{playground_url}' target='_new' class='playground btn btn-xs btn-primary active' role='button'>Run</a>").strip
      end

      def render(context)
        #calls render on Liquid::Block, which returns the content of the block
        self.raw = self.method(:render).super_method.super_method.call(context).to_s.strip
        self.gist_id = options_hash[:gist_id]
        super
      end

      # The @options ivar was renamed to @highlight_options in commit:
      # https://github.com/jekyll/jekyll/commit/a7730914df272d003de6d3b63669e8e8417e0c61
      def options_hash
        instance_variable_get(:@highlight_options) || instance_variable_get(:@options)
      end

      def playground_url
        PlaygroundLink.build(self).url
      end
    end

    class PlaygroundLink < SimpleDelegator
      def self.build(rust_highlight_block)
        link_type = [GistGenerated, DynamicallyGenerated, InvalidType].detect { |type| type.block_allowed?(rust_highlight_block) }

        new(
          link_type.new(
            rust_highlight_block.send(link_type.required_value)
          )
        )
      end

      def url
        "https://play.rust-lang.org/?#{query_string}"
      end
    end

    class LinkType
      def self.block_allowed?(block)
        block.public_send(self.required_value)
      rescue
        false
      end

      def self.required_value
        :object_id
      end

      def initialize(x)
        self.query_value = x
      end

      def query_string
        ""
      end

      private

      attr_accessor :query_value
    end

    class GistGenerated < LinkType
      def self.required_value
        :gist_id
      end

      def query_string
        "gist=#{query_value}"
      end
    end

    class DynamicallyGenerated < LinkType
      def self.required_value
        :raw
      end

      def query_string
        "code=#{CGI.escape(query_value)}"
      end
    end

    class InvalidType < LinkType
      def self.block_allowed?(_)
        true
      end
    end

    Liquid::Template.register_tag(
      'rp_highlight',
      Jekyll::Tags::RustPlaygroundHighlight
    )
  end
end
