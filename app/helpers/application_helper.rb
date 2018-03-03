module ApplicationHelper

  def highlight_code(text_match)
    fragment = text_match.fragment
    matches = text_match.matches

    start_index = 0
    code = ""

    matches.each do |match|
      end_index = match.indices.first - 1
      code << content_tag(:span, fragment[start_index..end_index])
      code << content_tag(:span, match.text, class: "highlight")
      start_index = match.indices.last
    end

    code << content_tag(:span, fragment[start_index..(fragment.length - 1)])
    code.html_safe
  end

end
