module ApplicationHelper
  class ChordsAndLyrics < Redcarpet::Render::HTML
    CHORD_NAME           = "[CDEFGABcdefgab](#|##|b|bb)?(m|maj7|maj|min7|min|sus2)?"
    CHORD_NAME_MULTIPLE  = "(#{CHORD_NAME}([ ])?)+"
    SONG_PARTS           = "CHORUS"

    CHORD_REGEX          = /(?<chord>\[#{CHORD_NAME_MULTIPLE}\])/
    NOTATION_REGEX       = /(?<chord>\[#{SONG_PARTS}\])/
    BRACKET_REGEX        = /(?<chord>\[.*?\])/

    def initialize(options={})
      super options.merge(:hard_wrap => true)
    end

    def chord_markup(text)
      text.gsub!(CHORD_REGEX,    '<span class="chord">\k<chord></span>')
      text.gsub!(NOTATION_REGEX, '<span class="notation">\k<chord></span>')
      text
    end

    def hard_wrap(text)
      lines = text.split(/\n/).map do |t|
        classes = 'line-break'
        classes = classes + ' with-chords' if CHORD_REGEX =~ t
        classes = classes + ' with-notation' if NOTATION_REGEX =~ t
        "<span class='#{classes}'>#{t}</span>"
      end
      lines.join()
    end

    def paragraph(t)
      c = chord_markup(t)
      text = hard_wrap(c)
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
