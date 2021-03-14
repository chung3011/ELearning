module ApplicationHelper
  def full_title page_title = ""
    base_title = "Learning Online"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  MAX_RATING = 5

  def render_stars(value)
    output = ''
    if value.nil?
      MAX_RATING.times{ output << '<i class="fas fa-star star-not"></i>' }
    else
      value.floor.times { output << '<i class="fas fa-star star"></i>' }
      output << '<i class="fas fa-star-half-alt star"></i>' if value > value.floor
      (MAX_RATING - value.ceil()).times { output << '<i class="fas fa-star star-not"></i>' }
    end
    output.html_safe
  end
end
