class WelcomeController < AuthenticatedController
  def index; end

  def build_invoices
    @data = {}
    Invoice.paid.where(reference_year: 2022).each do |invoice|
      member_key = invoice.member_id.to_s
      month_key = invoice.reference_month.to_s

      @data['values'] ||= {}
      @data['values'][member_key] ||= {}
      @data['values'][member_key][month_key] ||= 0
      @data['values'][member_key][month_key] += invoice.value

      @data['total'] ||= {}
      @data['total'][month_key] ||= 0
      @data['total'][month_key] += invoice.value
      @data['total']['year'] ||= 0
      @data['total']['year'] += invoice.value
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "invoices", orientation: 'Landscape', layout: 'pdf', formats: [:html]
      end
    end
  end
end
