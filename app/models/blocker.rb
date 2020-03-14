class Blocker
  def initialize(params)
    @week = params[:week]
    @slot = Slot.find(params[:slot]) if params[:slot]
    @date = params[:date]
  end

  def display
    if @week
      @week.to_date.strftime('Semana %U, %Y')
    elsif @slot
      @slot.display + ' ' + I18n.l(@date.to_date)
    else
      I18n.l(@date.to_date)
    end
  end
end