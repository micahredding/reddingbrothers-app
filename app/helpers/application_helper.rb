module ApplicationHelper
  def markdown_renderer
    @markdown_renderer ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(
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
