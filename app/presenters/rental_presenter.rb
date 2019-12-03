class RentalPresenter < SimpleDelegator
  attr_reader :current_user
  include Rails.application.routes.url_helpers
  delegate :content_tag, :link_to, to: :helper

  def initialize(rental, user)
    super(rental)
    @current_user = user
  end

  def status_badge
    content_tag :span, class: "badge badge-#{status_class}" do
      I18n.translate(status.to_s)
    end
  end

  def current_action
    if scheduled?
      link_to 'Iniciar Locação', review_rental_path(id)
    elsif ongoing?
      link_to 'Encerrar Locação', closure_review_rental_path(id)
    elsif in_review?
      link_to 'Continuar Locação', review_rental_path(id)
    elsif finalized? && current_user.admin?
      link_to 'Reportar Problema', report_rental_path(id)
    else 
      return ""
    end
  end

  private

  def helper
    ApplicationController.helpers
  end

  def status_class
    status_classes = {
      scheduled: 'primary',
      ongoing: 'info',
      in_review: 'danger',
      finalized: 'success'
    }

    status_classes[status.to_sym]
  end
end
