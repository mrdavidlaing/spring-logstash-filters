# encoding: utf-8
require 'test/filter_test_helpers'

describe LogStash::Filters::Grok do

 context 'when parsing a spring message' do

    before(:all) do
      load_filters <<-CONFIG
        filter {
          #{File.read("src/logstash-filters/snippets/spring.conf")}
        }
      CONFIG
    end

    when_parsing_log("syslog" => { "message" => '2016-04-19 14:34:24.288 DEBUG 14 --- [tions.default-1] u.c.s.f.i.InstructionTrackerProcessor    : {"filename":"MT103 format.txt","dateToPay":"2016-04-19"}' }) do

      it "adds the spring tag" do
        expect(subject['tags']).to include("spring")
      end

      it "extracts the timestamp" do
        expect(subject['@timestamp']).to eq Time.parse("2016-04-19 14:34:24.288Z")
      end

      it "extracts spring logtime" do
        expect(subject['spring']['logtime']).to eq "2016-04-19 14:34:24.288"
      end
      
      it "extracts spring loglevel" do
        expect(subject['spring']['loglevel']).to eq "DEBUG"
      end
      
      it "extracts spring pid" do
        expect(subject['spring']['pid']).to eq "14"
      end
      
      it "extracts spring threadname" do
        expect(subject['spring']['threadname']).to eq "tions.default-1"
      end
      
      it "extracts spring classname" do
        expect(subject['spring']['classname']).to eq "u.c.s.f.i.InstructionTrackerProcessor"
      end
      
    end
    
  end
end
