module Admin::BrandsHelper

  def render_brand_status(brand)
    if brand.is_hidden
      content_tag(:span, "", :class => "fa fa-lock fa-fw")
    else
      content_tag(:span, "", :class => "fa fa-globe fa-fw")
    end
  end

end
