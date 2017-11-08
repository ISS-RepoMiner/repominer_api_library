# Holds full DailyDownload's information
ConnectToDB.call('parse_responses')
class DailyDownload < Sequel::Model
  many_to_one :repos
end
