# encoding: utf-8
require "test/filter_test_helpers"

describe 'Logstash filters' do

  before(:all) do
    load_filters <<-CONFIG
      filter {
        #{File.read('target/logstash-filters-spring.conf')}
      }
    CONFIG
  end

  context "when parsing app log from spring.io app" do
    when_parsing_log(
      "message" => '1291 <14>1 2016-04-19T14:34:24.288688+00:00 loggregator 6674080d-04be-41c4-8843-0a6287bf556e [APP] - - 2016-04-19 14:34:24.288 DEBUG 14 --- [tions.default-1] u.c.s.f.i.InstructionTrackerProcessor    : {"filename":"MT103 format.txt","uploadedTimeStamp":{"hour":14,"minute":34,"second":23,"nano":976000000,"year":2016,"month":"APRIL","dayOfMonth":19,"dayOfWeek":"TUESDAY","dayOfYear":110,"monthValue":4,"chronology":{"calendarType":"iso8601","id":"ISO"}},"processedTimeStamp":{"hour":14,"minute":34,"second":23,"nano":976000000,"year":2016,"month":"APRIL","dayOfMonth":19,"dayOfWeek":"TUESDAY","dayOfYear":110,"monthValue":4,"chronology":{"calendarType":"iso8601","id":"ISO"}},"status":"PENDING","bank":"CATEGB21XXXX","sponsorBank":"RBOSGB2LXGPL","bankUrn":"160216003181234","dateForValue":"2016-02-16","amount":"1903.35","currency":"GBP","charges":"OUR","transactionType":"/FDP/","remitterSortCode":"165710","remitterBankAccount":"56221234","remitterAddress":"AAAAWN CORNERAAAAHAMPTONTN175BD","remitterName":"AAAAECH LIMITED","remitterReference":null,"beneficiarySortCode":"010071","beneficiaryBankAccount":"13551973","beneficiaryAddress":"","beneficiaryName":"AAAAMason","beneficiaryReference":"/RFB/AAAATech Ltd","dateOfRequest":"2016-04-19","timeOfRequest":"02:34:24","dateToPay":"2016-04-19"}') do

        it "applies the syslog parsers successfully" do
          expect(subject['tags']).to include 'syslog'
        end
        it "applies the spring parsers successfully" do
          expect(subject['tags']).to include 'spring'
        end
      end
  end

end
