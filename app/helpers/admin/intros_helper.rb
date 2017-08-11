module Admin::IntrosHelper

  # 显示 Public/Hidden 状态
  def render_intro_status(intro)
    if intro.is_hidden
      content_tag(:span, "", :class => "fa fa-lock fa-fw")
    else
      content_tag(:span, "", :class => "fa fa-globe fa-fw")
    end
  end

  # 显示 Publish/Hide 按钮
  def render_intro_publish_or_hide(intro)
    if intro.is_hidden
      link_to(t('btn-publish'), publish_admin_intro_path(intro), :method => :post, :class => 'btn btn-sm btn-default')
    else
      link_to(t('btn-hide'), hide_admin_intro_path(intro), :method => :post, :class => 'btn btn-sm btn-default')
    end
  end

end
