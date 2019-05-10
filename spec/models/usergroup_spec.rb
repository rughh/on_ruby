require 'spec_helper'

describe Usergroup do
  let(:every_second_wednesday) { Usergroup.new.tap { |it| it.recurring = 'second wednesday 18:30' } }
  let(:every_last_wednesday)   { Usergroup.new.tap { |it| it.recurring = 'last wednesday 18:30' } }
  let(:rughh) { Whitelabel.label_for('hamburg') }
  let(:colognerb) { Whitelabel.label_for('cologne') }

  context 'parsing of recurring' do
    context 'as string' do
      it 'parses recurring and translates it' do
        expect(every_second_wednesday.localized_recurring).to eql('jeden 2. Mittwoch im Monat')
        expect(every_last_wednesday.localized_recurring).to eql('jeden letzten Mittwoch im Monat')
      end
    end

    context 'as date/time' do
      let(:karlsruhe) { Whitelabel.label_for('karlsruhe') }
      let(:_1830) { Usergroup.new.tap { |it| it.recurring = 'second wednesday 18:30' } }
      let(:parisrb) { Usergroup.new.tap { |it| it.recurring = 'last wednesday 20:00' } }

      let(:some_date) { Time.new(2011, 9, 1, 0, 0, 0) }
      let(:first_wednesday) { Time.new(2011, 9, 7, 0, 0, 0) }
      let(:second_wednesday) { Time.new(2011, 9, 14, 0, 0, 0) }
      let(:third_wednesday) { Time.new(2011, 9, 21, 0, 0, 0) }
      let(:fourth_wednesday) { Time.new(2011, 9, 28, 0, 0, 0) }

      context '#next_event_date' do
        it 'should always be in the future on wednesday' do
          [rughh, colognerb, karlsruhe, _1830, parisrb].each do |usergroup|
            expect(usergroup.next_event_date).to be_wednesday
            expect(usergroup.next_event_date).to be > Date.today
          end
        end

        it 'should include the parsed time, also' do
          expect(_1830.next_event_date.hour).to eq(18)
          expect(_1830.next_event_date.min).to eq(30)
        end
      end

      context '#parse_recurring_date' do
        it 'should find the right wednesday' do
          expect(rughh.parse_recurring_date(some_date)).to eql(second_wednesday)
          expect(colognerb.parse_recurring_date(some_date)).to eql(third_wednesday)
          expect(parisrb.parse_recurring_date(some_date)).to eql(fourth_wednesday)
        end

        context 'with the 1. of month being a wednesday' do
          let(:some_date) { Time.new(2019, 5, 9, 0, 0, 0) }
          let(:first_wednesday) { Time.new(2019, 5, 1, 0, 0, 0) }
          let(:second_wednesday) { Time.new(2019, 5, 8, 0, 0, 0) }
          let(:third_wednesday) { Time.new(2019, 5, 15, 0, 0, 0) }
          let(:last_wednesday) { Time.new(2019, 5, 29, 0, 0, 0) }

          it 'should find the right wednesday' do
            expect(rughh.parse_recurring_date(some_date)).to eql(second_wednesday)
            expect(colognerb.parse_recurring_date(some_date)).to eql(third_wednesday)
            expect(parisrb.parse_recurring_date(some_date)).to eql(last_wednesday)
          end
        end
      end

      context '#parse_recurring_time' do
        it 'should return a time with 19:00 as default' do
          parsed_time = karlsruhe.parse_recurring_time
          expect(parsed_time.hour).to eql(19)
          expect(parsed_time.min).to eql(0)
        end

        it 'should parse the recurring time' do
          rughh.recurring = 'second wednesday 18:30'
          parsed_time = rughh.parse_recurring_time
          expect(parsed_time.hour).to eql(18)
          expect(parsed_time.min).to eql(30)
        end
      end
    end
  end

  context '#custom_recurring' do
    specify do
      expect(colognerb.custom_recurring).to eql true
      expect(rughh.custom_recurring).to eql nil
    end
  end

  context '#localized_custom_recurrence' do
    context 'no custom recurring' do
      it 'should return nil' do
        expect(rughh.localized_custom_recurrence).to eql nil
      end
    end

    context 'with custom recurring' do
      specify 'de' do
        I18n.with_locale(:de) do
          expect(colognerb.localized_custom_recurrence).to eql 'jeweils am 3. Mittwoch in jedem 2. Monat (Januar, März, Mai, Juli, September, November) um 19:00 Uhr'
        end
      end

      specify 'en' do
        I18n.with_locale(:en) do
          expect(colognerb.localized_custom_recurrence).to eql 'every 3rd Wednesday in every second month (January, March, May, July, September, November) at 7:00 p.m.'
        end
      end

      specify 'es' do
        I18n.with_locale(:es) do
          expect(colognerb.localized_custom_recurrence).to eql '3er Miércoles de Enero, Marzo, Mayo, Julio, Septiembre y Noviembre, a las 19.00'
        end
      end

      context 'translation for locale is missing (> es)' do
        it 'should fall back to default_locale of Whitelabel (> de)' do
          I18n.with_locale(:es) do
            default_translation = 'jeweils am 3. Mittwoch in jedem 2. Monat (Januar, März, Mai, Juli, September, November) um 19:00 Uhr'
            allow(I18n).to receive(:tw).with('custom_recurrence').and_return('n/a')
            allow(I18n).to receive(:tw).with('custom_recurrence', locale: colognerb.default_locale).and_return(default_translation)
            expect(colognerb.localized_custom_recurrence).to eql default_translation
          end
        end
      end
    end
  end
end
