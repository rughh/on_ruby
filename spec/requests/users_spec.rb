require 'spec_helper'

describe 'Users', type: :request do
  describe 'GET /users/:id' do
    it 'shows a user who organised an event' do
      get user_path(create(:organizer_user))

      expect(response).to be_ok
    end

    it 'shows a user who participated in an event' do
      get user_path(create(:participant_user))

      expect(response).to be_ok
    end

    it 'is not found for a user who never participated' do
      get user_path(create(:user))

      expect(response).to be_not_found
    end

    it 'shows their own profile even without participation' do
      user = login_as(create(:user))

      get user_path(user)

      expect(response).to be_ok
    end

    it 'does not fail for a signed-in user without an email' do
      user = login_as(create(:user, email: nil))

      get user_path(user)

      expect(response).to be_ok
    end
  end

  describe 'GET /users/:id/edit' do
    it 'redirects an anonymous visitor with an alert' do
      get edit_user_path(create(:user))

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(I18n.t('flash.not_authenticated'))
    end

    it 'redirects a signed-in user trying to edit someone else' do
      login_as(create(:user))

      get edit_user_path(create(:user))

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(I18n.t('flash.not_authenticated'))
    end

    it 'clears and invalidates the name input when the name is unfilled' do
      user = login_as(create(:user))
      user.update!(name: User::EMPTY_NAME)

      get edit_user_path(user)

      input = Nokogiri::HTML(response.body).at_css('.form-group.user_name.form-group-invalid input')
      expect(input).not_to be_nil
      expect(input[:value].to_s.strip).to eq('')
    end
  end

  describe 'GET /users/:id/calendar' do
    it 'renders an ical feed' do
      get calendar_user_path(create(:participant_user), format: :ics)

      expect(response.body).to match(/BEGIN:VCALENDAR/)
    end
  end

  describe 'PATCH /users/:id' do
    let(:params) { { user: { github: 'testo', linkedin: 'testyin', freelancer: true, available: true } } }

    it 'updates the allow-listed attributes of the current user' do
      user = login_as(create(:user))

      patch user_path(user), params: params

      expect(response).to be_redirect
      expect(user.reload).to have_attributes(github: 'testo', linkedin: 'testyin', freelancer: true, available: true)
    end

    it 'ignores attributes that are not allow-listed' do
      user = login_as(create(:user))

      expect { patch user_path(user), params: { user: { nickname: 'not_allowed' } } }
        .not_to(change { user.reload.nickname })
    end

    it 'updates nothing for a stranger' do
      patch user_path(create(:user)), params: params

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(I18n.t('flash.not_authenticated'))
    end

    it 'refuses when a signed-in user targets someone else' do
      login_as(create(:user))
      other = create(:user, github: 'untouched')

      patch user_path(other), params: params

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(I18n.t('flash.not_authenticated'))
      expect(other.reload.github).to eq('untouched')
    end
  end

  describe 'DELETE /users/:id' do
    it 'deletes the current user and logs them out' do
      user = login_as(create(:user))

      expect { delete user_path(user) }.to change(User, :count).by(-1)
      expect(response).to redirect_to(destroy_session_path)
      expect(flash[:notice]).not_to be_nil
    end

    it 'does not delete a user who organises events' do
      event = create(:event)
      login_as(event.user)

      expect { delete user_path(event.user) }.not_to change(User, :count)
      expect(response).to redirect_to(edit_user_path(event.user))
      expect(flash[:alert]).not_to be_nil
    end
  end
end
