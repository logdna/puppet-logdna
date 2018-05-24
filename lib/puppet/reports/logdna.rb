require 'puppet'
require 'yaml'
require 'macaddr'
require 'json'
require 'time'
require 'logdna'

Puppet::Reports.register_report(:logdna) do

	configFile = File.join([File.dirname(Puppet.settings[:config]), "logdna.yaml"])
	if not File.exist?(configFile)
		raise(Puppet::ParseError, "#{configFile} can't be found/parsed")
	end
	config = YAML.load_file(configFile)

	if !config.key?(:logdna_key) or config[:logdna_key].nil? or config[:logdna_key].include? "<"
		raise ArgumentError, "Missing LogDNA Ingestion Key"
	end

	LOGDNA_INGESTION_KEY = config[:logdna_key]
	LOGDNA_OPTIONS = {:hostname => self.host, :index_meta => true, :mac => Mac.addr}

	@ldna = Logdna::Ruby.new(LOGDNA_INGESTION_KEY, LOGDNA_OPTIONS)

	desc <<-DESC
	Reporting to LogDNA
	DESC

	def process

		logLevels = {
			"DEBUG" => 0,
			"INFO" => 0,
			"NOTICE" => 0,
			"WARNING" => 0,
			"ERR" => 0,
			"ALERT" => 0,
			"EMERG" => 0,
			"CRIT" => 0
		}

		logLevelParts = Array.new
		logLevels.each do |level, count|
			logLevelParts << level+": "+count.to_s
		end

		self.logs.each do |log|
			logLevels[log.level.to_s.upcase] += 1
		end

		if self.status.nil?
			status = "INFO"
		else
			status = self.status.upcase
		end

		elapsedTime = (self.logs.last.time-self.logs.first.time).strftime('%s')

		meta = {
			"logs" => self.logs,
			"startTime" => self.logs.first.time.utc.iso8601,
			"endTime" => self.logs.last.time.utc.iso8601,
			"elapsed" => elapsedTime.to_i,
			"version" => self.puppet_version,
			"format" => self.report_format,
			"metrics" => self.metrics,
			"environment" => self.environment,
			"master" => self.master,
			"job_id" => self.job_id
		}

		line = "in #{elapsedTime}s";
		unless meta[:master] == ""
			line << " | "+meta[:master]
		end
		unless meta[:job_id].nil? or meta[:job_id] == ""
			line << " | "+meta[:job_id]
		end
		unless logLevelParts.empty?
			line << "\n" + logLevelParts.join(" | ")
		end

		sendLog status line meta

	end

	def sendLog(status, line, metaData)
		unless @ldna.nil?
			ldna.log(line, {:meta => metaData, :app => "puppet", :level => status})
		else
			Puppet.info "LogDNA Handler has not been set properly"
		end
	rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT => e
		Puppet.info "Connection error:\n"+e
	end

end
