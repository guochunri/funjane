module Admin::OrdersHelper

  def render_order_paid_state(order)
    if order.is_paid
      t('order-state-paid')
    else
      t('order-state-unpaid')
    end
  end

end
