class RentalPresenter < SimpleDelegator
  attr_reader :rental

  delegate :content_tag, to: :helper

  # def initialize(rental)
  #   super(rental)
  # end

  def status_badge
      content_tag :span, class: "badge badge-#{status}" do
      I18n.t(status)
    end
  end

  # def status_badge
  #     content_tag :span, class: "badge badge-#{rental.status}" do
  #     I18n.t(rental.status)
  #   end
  # end

  private

  def helper
    @helper ||= ApplicationController.helpers
  end
end
