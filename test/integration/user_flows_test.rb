require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "can register and logout" do
    get service_slots_path(services(:one))
    assert_response :redirect
    follow_redirect!
    assert_response :success
    
    get '/users/sign_up'
    assert_select "h2", "Crear cuenta"

    post "/users",
      params: { user: { email: 'user+new@mail.com', password: 'useruser', password_confirmation: 'useruser' } }
    follow_redirect!
    assert_select "a", "Salir"
    assert_select "a", services(:one).name
    assert_select "h2", 'Citas disponibles'
    
    delete destroy_user_session_path
    follow_redirect!
    assert_select "h2", "Iniciar sesión"
  end

  test "can book a slot and unbook it" do
    Timecop.freeze(Date.today.beginning_of_day)

    get service_slots_path(services(:one))
    follow_redirect!
    assert_select "h2", "Iniciar sesión"

    post user_session_path,
      params: { user: { email: users(:one).email, password: 'useruser' } }
    follow_redirect!
    assert_select 'p.name', I18n.l(Date.today)
    assert_select 'a', "Siguientes >>"
    assert_select "a", {count: 0, text: "<< Anteriores"}
    assert_select 'a.btn', '8:00AM'

    get service_slots_path(services(:one), date: Date.tomorrow.to_s)
    assert_select 'p.name', I18n.l(Date.tomorrow)
    assert_select 'a', "Siguientes >>"
    assert_select 'a', "<< Anteriores"
    assert_select 'a', '8:00AM'

    get new_slot_event_path(slots(:tomorrow_8am), date: Date.tomorrow.to_s)
    assert_select 'h2', "Reservar #{slots(:tomorrow_8am).display}, #{I18n.l Date.tomorrow}"
    assert_select '#event_user_attributes_name[value=?]', 'User One'
    assert_select '#event_user_attributes_phone[value=?]', 'phone1'

    file = fixture_file_upload(Rails.root.join('test', 'fixtures', 'files', 'sample.png'), 'image/png')
    assert_difference('ActiveStorage::Attachment.count', 1) do
      post slot_events_path(slots(:tomorrow_8am)),
        params: { event: { date: Date.tomorrow, note: 'My Note', payment_screenshot: file,
                          user_attributes: { name: 'User One edited', phone: 'phone1 edited'} } }
    end
    follow_redirect!

    assert_select 'div.alert', 'Cita reservada éxitosamente'
    assert_select 'h2', 'Mis Citas'
    assert_select 'td', 'Service 1'
    assert_select 'td', /#{I18n.l(Date.tomorrow, format: :short)}/
    assert_select 'td', /8:00AM/
    assert_select 'td', /Madrid/

    get service_slots_path(services(:one), date: Date.tomorrow.to_s)
    assert_select 'p.name', I18n.l(Date.today + 7)

    delete event_path(slots(:tomorrow_8am).events.on_date(Date.tomorrow).first)
    follow_redirect!
    assert_select 'div.alert', 'Cita anulada éxitosamente'
    
    get service_slots_path(services(:one), date: Date.tomorrow.to_s)
    assert_select 'p.name', I18n.l(Date.tomorrow)
    assert_select 'a', "Siguientes >>"
    assert_select "a", "<< Anteriores"
    assert_select 'a', '8:00AM'
  end
end
