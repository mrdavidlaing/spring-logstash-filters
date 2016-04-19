# encoding: utf-8
require 'test/filter_test_helpers'

describe LogStash::Filters::Grok do

 context 'when parsing a sylog message in RFC3164 format from haproxy' do

    before(:all) do
      load_filters <<-CONFIG
        filter {
          #{File.read("src/logstash-filters/snippets/syslog.conf")}
        }
      CONFIG
    end

    when_parsing_log("message" => '1291 <14>1 2016-04-19T14:34:24.288688+00:00 loggregator 6674080d-04be-41c4-8843-0a6287bf556e [APP] - - message here') do

      it "adds the syslog tag" do
        expect(subject['tags']).to include("syslog")
      end

      it "extracts the timestamp" do
        expect(subject['@timestamp']).to eq Time.parse("2016-04-19T14:34:24.288Z")
      end

      it "extracts the syslogt.host" do
        expect(subject['syslog']['program']).to eq("loggregator")
      end

      it "extracts syslog.sd_params" do
        expect(subject['syslog']['sd_params']).to eq("APP")
      end
      
      it "extracts syslog.message" do
        expect(subject['syslog']['message']).to eq("message here")
      end
    end
    
  end
end
