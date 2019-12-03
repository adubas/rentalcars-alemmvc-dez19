class RentalPresenter < SimpleDelegator

  def initialize(rental)
    super(rental)
  end

  def status
    if scheduled?
      helper.content_tag :span, class: 'badge badge-primary' do
        'agendada'
      end
    elsif finalized?
      helper.content_tag :span, class: 'badge badge-success' do
        'finalizada'
      end
    elsif in_review?
      helper.content_tag :span, class: 'badge badge-warning' do
        'em revisão'
      end
    elsif ongoing?
      helper.content_tag :span, class: 'badge badge-info' do
        'em andamento'
      end
    end
  end

  private

  def helper
    ApplicationController.helpers
  end
end