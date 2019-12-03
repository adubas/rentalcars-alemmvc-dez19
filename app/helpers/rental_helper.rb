module RentalHelper

  def status_badge(rental)
    if rental.scheduled?
      content_tag :span, class: 'badge badge-primary' do
        'agendada'
      end
    elsif rental.finalized?
      content_tag :span, class: 'badge badge-success' do
        'finalizada'
      end
    elsif rental.in_review?
      content_tag :span, class: 'badge badge-warning' do
        'em revisão'
      end
    elsif rental.ongoing?
      content_tag :span, class: 'badge badge-info' do
        'em andamento'
      end
    end
  end
end