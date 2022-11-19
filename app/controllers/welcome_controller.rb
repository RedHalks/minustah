class WelcomeController < AuthenticatedController
  def index
    @pagy, @overdue_membership_members = pagy(Member.includes(:invoices).joins(:invoices).merge(Invoice.overdue))
  end
end
