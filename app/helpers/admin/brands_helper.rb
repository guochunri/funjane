module Admin::BrandsHelper

  #显示 Publish/Hidden 状态
  def render_brand_status(brand)
    if brand.is_hidden
      content_tag(:span, "", :class => "fa fa-lock fa-fw")
    else
      content_tag(:span, "", :class => "fa fa-globe fa-fw")
    end
  end

  #显示 Pbulish/Hidden 按钮
  def render_brand_publish_or_hide(brand)
    if brand.is_hidden
      link_to(t('btn-publish'), publish_admin_brand_path(brand), :method => :post, :class => 'btn btn-sm btn-default')
    else
      link_to(t('btn-hide'), hide_admin_brand_path(brand), :method => :post, :class => 'btn btn-sm btn-default')
    end
  end

end
