require 'spec_helper'

describe Usergroup do
  let(:every_second_wednesday) { Usergroup.new.tap { |it| it.recurring = 'second wednesday 18:30' } }
  let(:every_last_wednesday)   { Usergroup.new.tap { |it| it.recurring = 'last wednesday 18:30' } }

  context "parsing of recurring" do
    context "as string" do
      it "parses recurring and translates it" do
        expect(every_second_wednesday.localized_recurring).to eql('jeden 2. Mittwoch im Monat')
        expect(every_last_wednesday.localized_recurring).to eql('jeden letzten Mittwoch im Monat')
      end
    end

    context "as date/time" do
      let(:rughh) { Whitelabel.label_for("hamburg") }
      let(:colognerb) { Whitelabel.label_for("cologne") }
      let(:hackhb) { Whitelabel.label_for("bremen") }
      let(:karlsruhe) { Whitelabel.label_for("karlsruhe")}
      let(:_1830) { Usergroup.new.tap { |it| it.recurring = 'second wednesday 18:30' } }
      let(:parisrb) { Usergroup.new.tap { |it| it.recurring = 'last wednesday 20:00' } }

      let(:some_date) { Time.new(2011, 9, 1, 0, 0, 0) }
      let(:first_wednesday) { Time.new(2011, 9, 7, 0, 0, 0) }
      let(:second_wednesday) { Time.new(2011, 9, 14, 0, 0, 0) }
      let(:third_wednesday) { Time.new(2011, 9, 21, 0, 0, 0) }
      let(:fourth_wednesday) { Time.new(2011, 9, 28, 0, 0, 0) }

      context "#next_event_date" do
        it "should always be in the future on wednesday" do
          [rughh, hackhb, colognerb, karlsruhe, _1830, parisrb].each do |usergroup|
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
        it "should find the right wednesday" do
          expect(hackhb.parse_recurring_date(some_date)).to eql(first_wednesday)
          expect(rughh.parse_recurring_date(some_date)).to eql(second_wednesday)
          expect(colognerb.parse_recurring_date(some_date)).to eql(third_wednesday)
          expect(parisrb.parse_recurring_date(some_date)).to eql(fourth_wednesday)
        end
      end

      context '#parse_recurring_time' do
        it "should return a time with 19:00 as default" do
          parsed_time = hackhb.parse_recurring_time
          expect(parsed_time.hour).to eql(19)
          expect(parsed_time.min).to eql(0)
        end

        it "should parse the recurring time" do
          rughh.recurring = 'second wednesday 18:30'
          parsed_time = rughh.parse_recurring_time
          expect(parsed_time.hour).to eql(18)
          expect(parsed_time.min).to eql(30)
        end
      end
    end
  end
end
