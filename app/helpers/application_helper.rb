module ApplicationHelper
  class ChordsAndLyrics < Redcarpet::Render::HTML
    def initialize(options={})
      super options.merge(:hard_wrap => true)
    end

    def chord_markup(text)
      chord_name = "[CDEFGAB](#|##|b|bb)?(m|maj7|maj|min7|min|sus2)?"
      chord_name_multiple = "(#{chord_name}([ ])?)+"

      chord_regex = /(?<chord>\[#{chord_name}\])/
      chord_multiple_regex = /(?<chord>\[#{chord_name_multiple}\])/

      bracket_regex = /(?<chord>\[.*?\])/
      text.gsub(chord_multiple_regex, '<span class="chord">\k<chord></span>')
    end

    def hard_wrap(text)
      # text.gsub(/(.*\n)/, '<span class="line-break">\1</span>' + "\n")
      text.split(/\n/).map { |t| '<span class="line-break">' + t + '</span>' }.join()
    end

    def paragraph(t)
      # a = hard_wrap(chord_markup(t))
      b = chord_markup(hard_wrap(t))
      text = b
      "<p>#{text}</p>"
    end
  end


  def markdown_renderer
    @markdown_renderer ||= Redcarpet::Markdown.new(
      ChordsAndLyrics.new(
        :link_attributes => Hash["target" => "_blank"],
        :hard_wrap => true,
      ),
      :autolink => true,
      :space_after_headers => true,
      :footnotes => true,
    )
  end

  def markdown(text)
    return "" unless text
    markdown_renderer.render(text).html_safe
  end

  def teaser(text, length=300)
    strip_tags(text).truncate(length)
  end
end
